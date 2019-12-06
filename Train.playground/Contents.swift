import Cocoa
import CreateML

let dataSetURL = URL(fileURLWithPath: "/Users/m_quadra/Desktop/optTs/DataSet.csv")
let dataSet = try MLDataTable(contentsOf: dataSetURL)

//let model = try MLLogisticRegressionClassifier(trainingData: dataSet, targetColumn: "coding")
let model = try MLClassifier(trainingData: dataSet, targetColumn: "coding")
//let model = try MLTextClassifier(trainingData: dataSet, textColumn: "hex", labelColumn: "coding")

let metadata = MLModelMetadata(author: "M_Quadra", shortDescription: "Auto Guess Encoding", version: "0.1.0")
try model.write(to: URL(fileURLWithPath: "/Users/m_quadra/Desktop/optTs/MQAutoGuessEncoding.mlmodel"), metadata: metadata)

