/*
In each simulation, a packet is sent from a randomly chosen STA to the AP. 
If RTS/CTS is enabled, the STA sends an RTS to the AP, which responds with a CTS. 
The STA then sends the packet, which is received by the AP. The AP sends an ACK back to the STA, 
completing the transmission process.

In the scenario with retransmission, 
the program simulates a collision by not receiving the packet from the STA. 
The STA then retransmits the packet, which is received by the AP, 
and the AP sends an ACK back to the STA.
*/

#include <iostream>
#include <vector>
#include <string>
#include <cstdlib> // For rand() and srand()
#include <ctime> // For time()

class Node {
public:
    std::string name;
    int position;

    Node(const std::string& name, int position) : name(name), position(position) {}
};

class Environment {
public:
    Node ap;
    std::vector<Node> stas;

    Environment(int ap_position, const std::vector<int>& sta_positions)
        : ap("AP", ap_position) {
        for (size_t i = 0; i < sta_positions.size(); ++i) {
            stas.emplace_back("STA" + std::to_string(i), sta_positions[i]);
        }
    }
};

void simulate_packet_transmission(const Environment& env, bool with_rts_cts) {
    int sender_index = rand() % env.stas.size();
    const Node& sender = env.stas[sender_index];
    const Node& receiver = env.ap;

    if (with_rts_cts) {
        std::cout << sender.name << " sends RTS to " << receiver.name << std::endl;
        std::cout << receiver.name << " sends CTS to " << sender.name << std::endl;
    }

    std::cout << sender.name << " sends packet to " << receiver.name << std::endl;
    std::cout << receiver.name << " receives packet from " << sender.name << std::endl;
    std::cout << receiver.name << " sends ACK to " << sender.name << std::endl;
    std::cout << sender.name << " receives ACK from " << receiver.name << std::endl;
}

void simulate_packet_transmission_with_retransmission(const Environment& env, bool with_rts_cts) {
    int sender_index = rand() % env.stas.size();
    const Node& sender = env.stas[sender_index];
    const Node& receiver = env.ap;

    if (with_rts_cts) {
        std::cout << sender.name << " sends RTS to " << receiver.name << std::endl;
        std::cout << receiver.name << " sends CTS to " << sender.name << std::endl;
    }

    std::cout << sender.name << " sends packet to " << receiver.name << std::endl;
    std::cout << receiver.name << " does not receive packet from " << sender.name << std::endl;
    std::cout << sender.name << " retransmits packet to " << receiver.name << std::endl;
    std::cout << receiver.name << " receives packet from " << sender.name << std::endl;
    std::cout << receiver.name << " sends ACK to " << sender.name << std::endl;
    std::cout << sender.name << " receives ACK from " << receiver.name << std::endl;
}

int main() {
    srand(time(0)); // Seed random number generator

    int ap_position = 0;
    std::vector<int> sta_positions = {1, 2}; // STAs are at positions 1 and 2
    Environment env(ap_position, sta_positions);

    // Simulate packet transmission without RTS/CTS
    std::cout << "Simulating packet transmission without RTS/CTS:" << std::endl;
    simulate_packet_transmission(env, false);

    // Simulate packet transmission with RTS/CTS
    std::cout << "\nSimulating packet transmission with RTS/CTS:" << std::endl;
    simulate_packet_transmission(env, true);

    // Simulate packet transmission with retransmission without RTS/CTS
    std::cout << "\nSimulating packet transmission with retransmission without RTS/CTS:" << std::endl;
    simulate_packet_transmission_with_retransmission(env, false);

    // Simulate packet transmission with retransmission and RTS/CTS
    std::cout << "\nSimulating packet transmission with retransmission and RTS/CTS:" << std::endl;
    simulate_packet_transmission_with_retransmission(env, true);

    return 0;
}
