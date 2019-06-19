import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:ihc_g2/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ihc_g2/datas/estimate_data.dart';

class EstimateModel extends Model {
  
  UserModel user;
  
  List<Estimate> products = [];

  String title;
  String description;

  bool isLoading = false; 

  EstimateModel(this.user){
    _loadUnsavedEstimate();
  }

  static EstimateModel of(BuildContext context) =>
    ScopedModel.of<EstimateModel>(context);

  void addEstimateItem(Estimate estimate){
     products.add(estimate);

     Firestore.instance
      .collection("users")
      .document(user.firebaseUser.uid)
      .collection("estimate")
      .add(estimate.toMap()).then((doc){
        estimate.eid = doc.documentID;
      });

      notifyListeners();
  }

  void decProduct (Estimate estimate){  //decrementa quantidade de produtos do novo orçamento
    estimate.quantity --;

    Firestore.instance
      .collection("users")
      .document(user.firebaseUser.uid)
      .collection("estimate")
      .document(estimate.eid)
      .updateData(estimate.toMap());

      notifyListeners();
  }

  void incProduct (Estimate estimate){  //incrementa quantidade de produtos do novo orçamento
    estimate.quantity ++;

    Firestore.instance
      .collection("users")
      .document(user.firebaseUser.uid)
      .collection("estimate")
      .document(estimate.eid)
      .updateData(estimate.toMap());

      notifyListeners();
  }

  void _loadUnsavedEstimate () async{

    
    QuerySnapshot query = await 
    Firestore.instance
      .collection("users")
      .document(user.firebaseUser.uid)
      .collection("estimate")
      .getDocuments();

      products = query.documents.map((doc) => Estimate.fromDocument(doc)).toList();

      notifyListeners();

  }

  void removeEstimateItem(Estimate estimate){  //remove produtos do novo orçamento
    Firestore.instance
      .collection("users")
      .document(user.firebaseUser.uid)
      .collection("estimate")
      .document(estimate.eid)
      .delete();

      products.remove(estimate);

      notifyListeners();
  }

  Future<String> saveEstimate(String title, String description) async{
    if (products.length == 0) return null;

    isLoading = true;
    notifyListeners();

    DocumentReference refEstimate = await Firestore.instance.collection("estimates").add(
      {
        "clienteId": user.firebaseUser.uid,
        "products": products.map((estimate)=>estimate.toMap()).toList(),
        "title": title,
        "description": description,
        "status": 1
      }
    );

    await Firestore.instance
      .collection("users")
      .document(user.firebaseUser.uid)
      .collection("estimates")
      .document(refEstimate.documentID)
      .setData({
        "estimateId": refEstimate.documentID
      });

    QuerySnapshot query = await Firestore.instance
      .collection("users")
      .document(user.firebaseUser.uid)
      .collection("estimate").getDocuments();

    for(DocumentSnapshot doc in query.documents){
      doc.reference.delete();
    }  

    products.clear();

    isLoading = false;

    notifyListeners();

    return refEstimate.documentID;

  }

}