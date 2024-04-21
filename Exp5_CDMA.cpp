#include <iostream>
#include <vector>

class CDMA {
private:
    std::vector<std::vector<int>> wtable;
    std::vector<std::vector<int>> copy;
    std::vector<int> channel_sequence;

public:
    void setUp(std::vector<int>& data, int num_stations) {
        wtable.resize(num_stations, std::vector<int>(num_stations));
        copy.resize(num_stations, std::vector<int>(num_stations));
        
        // Generate Walsh Table
        buildWalshTable(num_stations, 0, num_stations - 1, 0, num_stations - 1, false);
        
        // Display Walsh Table
        std::cout << "Walsh Table:\n";
        showWalshTable(num_stations);

        // Modify Walsh Table with data
        for (int i = 0; i < num_stations; i++) {
            for (int j = 0; j < num_stations; j++) {
                copy[i][j] = wtable[i][j];
                wtable[i][j] *= data[i];
            }
        }

        // Calculate channel sequence
        channel_sequence.resize(num_stations);
        for (int i = 0; i < num_stations; i++) {
            for (int j = 0; j < num_stations; j++) {
                channel_sequence[i] += wtable[j][i];
            }
        }
    }

    void listenTo(int sourceStation, int num_stations) {
        int innerProduct = 0;
        for (int i = 0; i < num_stations; i++) {
            innerProduct += copy[sourceStation][i] * channel_sequence[i];
        }
        
        // Display data received
        std::cout << "\nThe data received is: " << (innerProduct / num_stations) << std::endl;
    }

    int buildWalshTable(int len, int i1, int i2, int j1, int j2, bool isBar) {
        if (len == 2) {
            if (!isBar) {
                wtable[i1][j1] = 1;
                wtable[i1][j2] = 1;
                wtable[i2][j1] = 1;
                wtable[i2][j2] = -1;
            } else {
                wtable[i1][j1] = -1;
                wtable[i1][j2] = -1;
                wtable[i2][j1] = -1;
                wtable[i2][j2] = 1;
            }
            return 0;
        }

        int midi = (i1 + i2) / 2;
        int midj = (j1 + j2) / 2;
        buildWalshTable(len / 2, i1, midi, j1, midj, isBar);
        buildWalshTable(len / 2, i1, midi, midj + 1, j2, isBar);
        buildWalshTable(len / 2, midi + 1, i2, j1, midj, isBar);
        buildWalshTable(len / 2, midi + 1, i2, midj + 1, j2, !isBar);
        return 0;
    }

    void showWalshTable(int num_stations) {
        for (int i = 0; i < num_stations; i++) {
            for (int j = 0; j < num_stations; j++) {
                std::cout << wtable[i][j] << "\t";
            }
            std::cout << std::endl;
        }
    }
};

int main() {
    int num_stations = 4;
    std::vector<int> data(num_stations);
    data[0] = -1;
    data[1] = -1;
    data[2] = 0;
    data[3] = 1;
    CDMA channel;
    channel.setUp(data, num_stations);
    int sourceStation = 3; // station you want to listen to
    channel.listenTo(sourceStation, num_stations);
    return 0;
}
