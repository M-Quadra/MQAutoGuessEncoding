import Cocoa
import CreateML

let dataSetURL = URL(fileURLWithPath: "/Users/m_quadra/Desktop/optTs/DataSet.csv")
let dataSet = try MLDataTable(contentsOf: dataSetURL)

//let model = try MLLogisticRegressionClassifier(trainingData: dataSet, targetColumn: "coding")
let model = try MLClassifier(trainingData: dataSet, targetColumn: "coding")

//MLClassifier(trainingData: <#T##MLDataTable#>, targetColumn: <#T##String#>)
