#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <cstdlib>
#include <limits>
#include <algorithm>
using namespace std;

class TestCompression {
public:
    TestCompression(const string& inputFile, size_t maxDictEntries, size_t vecLength, const string& outputFile)
        : maxDictEntries(maxDictEntries), vecLength(vecLength), outputFile(outputFile) {
        
        if (vecLength != 8 && vecLength != 16 && vecLength != 32 && vecLength != 64) {
            cerr << "Valid vector lengths are 8, 16, 32, or 64" << endl;
            exit(EXIT_FAILURE);
        }

        vectors = loadTestVectors(inputFile);
        if (vectors.empty()) {
            cerr << "No valid test vectors found." << endl;
            exit(EXIT_FAILURE);
        }

        graph = buildCompatibilityGraph();
    }

    vector<string> loadTestVectors(const string& fileName) {
        ifstream inputFile(fileName);
        if (!inputFile.is_open()) {
            cerr << "Wrong file name or Unable to open file" << endl;
            exit(EXIT_FAILURE);
        }

        vector<string> result;
        string line;

        while (getline(inputFile, line)) {
            if (line.length() % vecLength == 0) {
                for (size_t i = 0; i < line.length(); i += vecLength) {
                    result.push_back(line.substr(i, vecLength));
                }
            }
        }

        return result;
    }

    bool areCompatible(const string& vec1, const string& vec2) {
        for (size_t i = 0; i < vec1.length(); ++i) {
            if (vec1[i] != vec2[i] && vec1[i] != 'X' && vec2[i] != 'X') {
                return false;
            }
        }
        return true;
    }

    vector<vector<int>> buildCompatibilityGraph() {
        vector<vector<int>> graph(vectors.size());
        for (size_t i = 0; i < vectors.size(); ++i) {
            for (size_t j = i + 1; j < vectors.size(); ++j) {
                if (areCompatible(vectors[i], vectors[j])) {
                    graph[i].push_back(j);
                    graph[j].push_back(i);
                }
            }
        }
        return graph;
    }

    /*void displayGraph() {
        for (size_t i = 0; i < graph.size(); ++i) {
            cout << "Node " << i << ": ";
            for (int neighbor : graph[i]) {
                cout << neighbor << " ";
            }
            cout << endl;
        }
    }*/

   vector<vector<int>> extractDictionary() {
      vector<vector<int>> dictionary;
      vector<bool> visited(graph.size(), false);

      while (dictionary.size() < maxDictEntries) {
        size_t bestNode = -1, maxDegree = 0;

        for (size_t i = 0; i < graph.size(); ++i) {
            if (!visited[i] && graph[i].size() > maxDegree) {
                maxDegree = graph[i].size();
                bestNode = i;
            }
        }

        if (bestNode == -1) break;

        vector<int> entry = {(int)bestNode};
        visited[bestNode] = true;

        for (int neighbor : graph[bestNode]) {
            if (!visited[neighbor] && 
                all_of(entry.begin(), entry.end(), 
                    [&](int node) { return find(graph[neighbor].begin(), graph[neighbor].end(), node) != graph[neighbor].end(); }
                )) {
                entry.push_back(neighbor);
                visited[neighbor] = true;
            }
        }

        dictionary.push_back(entry);
    }

    return dictionary;
   } 

    void displayDictionary(const vector<vector<int>>& dictionary) {
        for (size_t i = 0; i < dictionary.size(); ++i) {
            cout << "Entry " << i + 1 << ": ";
            for (int idx : dictionary[i]) {
                cout << idx << " ";
            }
            cout << endl;
        }
    }

void writeDictionaryToFile(const vector<vector<int>>& dictionary) {
    ofstream output(outputFile);
    
    for (const auto& entry : dictionary) {
        string compressed(vecLength, 'X');
        for (int idx : entry) {
            for (int i = 0; i < vecLength; ++i) {
                if (vectors[idx][i] != 'X') {
                    compressed[i] = vectors[idx][i];
                }
            }
        }
        output << compressed << endl;
    }
}

private:
    size_t maxDictEntries;
    size_t vecLength;
    string outputFile;
    vector<string> vectors;
    vector<vector<int>> graph;
};

int main(int argc, char* argv[]) {
    if (argc != 5) {
        cerr << "Incorrect number of arguments : <inputFile> <maxDictEntries> <vectorLength> <outputFile>" << endl;
        return EXIT_FAILURE;
    }

    string inputFile = argv[1];
    size_t maxDictEntries = atoi(argv[2]);
    size_t vectorLength = atoi(argv[3]);
    string outputFile = argv[4];

    TestCompression engine(inputFile, maxDictEntries, vectorLength, outputFile);

    //engine.displayGraph();

    vector<vector<int>> dictionary = engine.extractDictionary();
    engine.displayDictionary(dictionary);

    if (dictionary.size() < maxDictEntries) {
        cout << "Only " << dictionary.size() << " dictionary entries available." << endl;
    }

    engine.writeDictionaryToFile(dictionary);

    return 0;
}
