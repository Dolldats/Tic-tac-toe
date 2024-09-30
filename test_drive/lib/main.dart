import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tic Tac Toe',
      home: TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<String?> board = List.filled(9, null);
  bool isXNext = true;
  String? winner;

  void resetGame() {
    setState(() {
      board = List.filled(9, null);
      isXNext = true;
      winner = null;
    });
  }

  void playMove(int index) {
    if (board[index] != null || winner != null) return;

    setState(() {
      board[index] = isXNext ? 'X' : 'O';
      isXNext = !isXNext;
      winner = _checkWinner();
    });
  }

  String? _checkWinner() {
    const winningCombos = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combo in winningCombos) {
      if (board[combo[0]] != null &&
          board[combo[0]] == board[combo[1]] &&
          board[combo[1]] == board[combo[2]]) {
        return board[combo[0]];
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            winner == null ? 'Turn: ${isXNext ? 'X' : 'O'}' : 'Winner: $winner',
            style: const TextStyle(fontSize: 24),
          ),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
            ),
            itemCount: 9,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => playMove(index),
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black),
                    color: Colors.blueAccent,
                  ),
                  child: Center(
                    child: Text(
                      board[index] ?? '',
                      style: const TextStyle(
                          fontSize: 40,
                          color: Color.fromARGB(255, 27, 158, 60)),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: resetGame,
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
