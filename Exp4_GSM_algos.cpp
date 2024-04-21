#include <iostream>
#include <iomanip>
#include <sstream>
#include <cstdlib>
#include <ctime>

// Simplified A3 algorithm for demonstration purposes
std::string A3(const std::string& key, const std::string& rand, const std::string& sres) {
    std::string x1 = rand + sres;
    std::string x2 = rand + key;
    std::string x3 = sres + key;    

    // Simplified XOR operation
    std::string result = "";
    for (size_t i = 0; i < x1.size(); ++i) {
        result += (x1[i] ^ x2[i] ^ x3[i]);
    }

    return result;
}

// Simplified A5 algorithm for demonstration purposes
std::string A5(const std::string& key, const std::string& input) {
    std::string result = "";
    for (size_t i = 0; i < input.size(); ++i) {
        // Simplified XOR operation
        result += (input[i] ^ key[i % key.size()]);
    }

    return result;
}

// Simplified A8 algorithm for demonstration purposes
std::string A8(const std::string& key, const std::string& input) {
    std::string result = "";
    for (size_t i = 0; i < input.size(); ++i) {
        // Simplified XOR operation
        result += (input[i] ^ key[i % key.size()]);
    }

    return result;
}

// Function to convert binary data to hexadecimal string
std::string toHexString(const std::string& binaryData) {
    std::stringstream ss;
    ss << std::hex << std::setfill('0');
    for (size_t i = 0; i < binaryData.size(); ++i) {
        ss << std::setw(2) << static_cast<int>(static_cast<unsigned char>(binaryData[i]));
    }
    return ss.str();
}

int main() {
    std::string key = "000102030405060708090A0B0C0D0E0F"; // Example key
    std::string rand = "1234567890ABCDEFFEDCBA9876543210"; // Example random number
    std::string sres = "112233445566778899AABBCCDDEEFF"; // Example SRES
    std::string input = "Hello, World!"; // Example input
    
    std::cout << "=============INPUT=============" << std::endl;
    std::cout << "key: " << key << std::endl;
    std::cout << "Random number: " << rand << std::endl;
    std::cout << "input string: " << input << std::endl;
    
    std::cout<<"\n";
    
    std::cout << "=============OUTPUT=============" << std::endl;
    std::string a3Result = A3(key, rand, sres);
    std::cout << "A3 Result: " << toHexString(a3Result) << std::endl;

    std::string a5Result = A5(key, input);
    std::cout << "A5 Result: " << toHexString(a5Result) << std::endl;

    std::string a8Result = A8(key, input);
    std::cout << "A8 Result: " << toHexString(a8Result) << std::endl;

    return 0;
}
