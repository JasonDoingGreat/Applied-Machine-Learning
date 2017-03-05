//
//  main.cpp
//  Neural Network
//
//  Created by Zezhou Li on 10/9/16.
//  Copyright © 2016 Zezhou Li. All rights reserved.
//

#include <iostream>
#include <unordered_map>
#include <vector>
#include <boost/lexical_cast.hpp>
#include <ctime>
#include <fstream>
#include <cstdlib>

using namespace std;

#define file1 "/Users/zezhouli/Documents/2016-2017 Fall Semester/CPE695-Machine Learning/Assignments/Assignment 2/Iris.csv"

const int m = 150;
const int n = 5;

double trainingdata[m][n];
double trainingresult[m];

class NeuralNetwork{
    
private:
    
    // Private Member Data
    double learningRate;
    vector<double> wi;
//    vector<double> dwi;
//    double HI = 0.05;
//    double LO = -0.05;
    int SampleSize;
    
public:
    
    NeuralNetwork(double givenRate) : learningRate(givenRate){}
    
    void Initialwi(int size) {
        privateInitialwi(size);
    }
    
    void GradientDescent(int size) {
        privateGradientDescent(size);
    };
    
//    void BackPropagation(int inputLayerSize, int hiddenLayerSize, int outputSize, int size) {
//        privateBackPropagation(inputLayerSize, hiddenLayerSize, outputSize, size);
//    }
    
    void PrintVector_wi() {
        privatePrintVector_wi();
    }
    
    void CalculateError(int size) {
        privateCalculateError(size);
    }
    
private:
    // Initial vector wi
    void privateInitialwi(int size) {
        wi.clear();
        for (int i = 0; i != size; ++i) {
            wi.push_back(0.0);
        }
    }
    
    double evaluate(int i, int size) {
        double current = wi[0];
        for (int j = 1; j < size; ++j) {
            current += wi[j] * trainingdata[i][j];
        }
        return current;
    }
    
    double sigmoidGradient(double x) {
        double y = 0.0;
        y = 1.0 / (1.0 + exp(-x));
        y *= (1.0-y);
        return y;
        
    }
    
//    void addOneToTrainData(int size) {
//        vector<double> new_data;
//        size_t last_j = 0;
//        for (size_t i = 0; i < traindatasize; ++i) {
//            new_data.push_back(1.0);
//            size_t j = 0;
//            for (j = last_j; j < last_j + size; ++j) {
//                new_data.push_back(traindata[j]);
//            }
//            last_j = j;
//        }
//        traindata.clear();
//        traindata = new_data;
//    }
    
    
    // Gradient Descent Method
    void privateGradientDescent(int size){
        privateInitialwi(size);
        double iteration = 500000;
        while (iteration--) {
            for (int i = 0; i<m; ++i) {
                double y = evaluate(i, size);
                // Compute w0
                wi[0] = wi[0] + learningRate * (trainingresult[i] - y);
                for (int j = 1; j<n; ++j) {
                    // Compute all weights from 1 to w
                    wi[j] = wi[j] + learningRate * (trainingresult[i] - y) * trainingdata[i][j];
                }
            }
        }
        
    }
    
//    // BackPropagation Method
//    void privateBackPropagation(int inputlayersize, int hiddenlayersize, int outputsize, int size) {
//        // Add a vector of ONE into the input training data
//        int K = outputsize;
//        addOneToTrainData(traindata, trainresult.size(), size);
//        
//        
//        
//    }
//    
    // CalculateError Function
    void privateCalculateError(int size) {
        int count = 0;
        for (int i = 0; i < m; ++i) {
            double y = evaluate(i, size);
            if ((int)y == trainingresult[i]) {
                count++;
            }
        }
        
        cout << "The accuracy is: " << (double)count / 150.0 << endl;
    }
    
    // Print Vector
    void privatePrintVector_wi() {
        for (vector<double>::iterator iter = wi.begin(); iter != wi.end(); ++iter) {
            cout << *iter << ' ';
        }
        cout << endl;
    }
    
};

vector<string> split(string str,string pattern) {
    
    string::size_type pos;
    vector<string> result;
    str += pattern;
    long size = str.size();
    
    for(long i=0; i<size; i++)
    {
        pos=str.find(pattern,i);
        if(pos<size)
        {
            string s=str.substr(i,pos-i);
            result.push_back(s);
            i=pos+pattern.size()-1;
        }
    }
    return result;
}

void ReadInData(fstream &file) {
    string temp_line;
    vector<string> result;
    double numresult = 0.0;
    for (int i = 0; i < 151; ++i) {
        
        getline(file, temp_line);
        result = split(temp_line, ",");
        if (result[0] == "Id") {
            i = -1;
            continue;
        }
        
        for (int j = 1; j < result.size(); ++j) {
            if (j == result.size()-1) {
                if (result[j] == "Iris-setosa") {
                    numresult = 1.0;
                } else {
                    if (result[j] == "Iris-versicolor") {
                        numresult = 2.0;
                    } else {
                        numresult = 3.0;
                    }
                }
                trainingresult[i] = numresult;
            } else {
                trainingdata[i][j] = stod(result[j]);
            }
        }
        
        result.clear();
        
    }
}

void printVectorElement(vector<double> vec) {
    for (size_t i = 0; i<vec.size(); ++i) {
        cout << vec[i] << ' ';
    }
}

int main(int argc, const char * argv[]) {
    
    NeuralNetwork NN(0.01);
    
    fstream trainingData;
    trainingData.open(file1);
    
    ReadInData(trainingData);
    
    NN.GradientDescent(5);
    NN.PrintVector_wi();
    NN.CalculateError(5);
    
    return 0;
}
