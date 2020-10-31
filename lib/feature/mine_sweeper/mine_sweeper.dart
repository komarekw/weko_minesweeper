import 'package:flutter/material.dart';
import 'package:minesweeper/feature/mine_sweeper/mine_sweeper_view_model.dart';
import 'package:minesweeper/layer/model/mine_sweeper_fields_model.dart';
import 'package:minesweeper/feature/mine_sweeper/mine_sweeper_fields.dart';
import 'package:provider/provider.dart';

class MineSweeper extends StatefulWidget {
  static final routeName = '/minesweeper';

  @override
  _MineSweeperState createState() => _MineSweeperState();
}

class _MineSweeperState extends State<MineSweeper> {
  SizeOfField _sizeOfField = SizeOfField.small;
  MineSweeperFieldsModel mineSweeperFields;

  void rerun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MineSweeper'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.white24,
          child: ChangeNotifierProvider<MineSweeperViewModel>(
            create: (context) => MineSweeperViewModel(_sizeOfField),
            child: Consumer<MineSweeperViewModel>(
              builder: (context, model, _) {
                return model.viewState == ViewState.idle
                    ? Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: () {
                              Navigator.of(context)
                                  .popAndPushNamed(MineSweeper.routeName);
                            },
                          ),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            MineSweeperFields(),
                            if (model.gameEnd)
                              getMessageWithButton('you won :-)'),
                            if (model.lose)
                              getMessageWithButton('you lost :-('),
                          ],
                        ),
                      ])
                    : CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget getMessageWithButton(String message) {
    return Column(
      children: [
        Text(
          message,
          style: TextStyle(fontSize: 50),
          textAlign: TextAlign.center,
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed(MineSweeper.routeName);
          },
          color: Colors.blue,
          child: Text('try again?'),
        ),
      ],
    );
  }
}
