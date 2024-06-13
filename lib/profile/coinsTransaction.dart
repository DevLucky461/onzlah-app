import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/pull_to_refresh.dart';
import 'package:onzlah_app/common/api.dart';
import 'package:onzlah_app/common/common.dart';
import 'package:onzlah_app/common/logout.dart';
import 'package:onzlah_app/model/coin_transaction.dart';

class CoinsTransaction extends StatefulWidget {
  @override
  _CoinsTransactionState createState() => _CoinsTransactionState();
}

class _CoinsTransactionState extends State<CoinsTransaction> {
  final logout = Logout();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLoading = true;
  int balance = 0;
  List<CoinTransaction> transactions = [];

  HDTRefreshController _hdtRefreshController = HDTRefreshController();

  static const int date = 0;
  static const int history = 1;
  static const int coins = 2;
  bool isAscending = false;
  int sortType = date;

  @override
  void initState() {
    getTransactionHistory();

    super.initState();
  }

  getTransactionHistory() async {
    balance = 0;
    transactions.clear();
    var data;
    var res = await CallApi().postData(data, 'view-coins');
    var body = json.decode(res.body);

    if (body['success'] == null || !body['success']) {
      logout.run(context);
    } else {
      transactions = CoinTransaction.getList(body);
      transactions.forEach((element) {
        balance += element.transaction_value;
      });
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Common.pink_dark_color,
          ),
        ),
        title: BackNavigation(),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Common.orange_color, Common.pink_light_color]),
        ),
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Coins Transaction",
              style: TextStyle(
                fontFamily: 'MontserratBold',
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Current balance: " + numberFormatter(balance),
              style: TextStyle(
                fontFamily: 'MontserratBold',
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : HorizontalDataTable(
                        leftHandSideColumnWidth: 0,
                        rightHandSideColumnWidth: MediaQuery.of(context).size.width - 30,
                        isFixedHeader: true,
                        headerWidgets: _getTitleWidget(),
                        leftSideItemBuilder: (context, index) => SizedBox(),
                        rightSideItemBuilder: _generateRightHandSideColumnRow,
                        itemCount: transactions.length,
                        rowSeparatorWidget: const Divider(
                          color: Colors.black54,
                          height: 1.0,
                          thickness: 0.0,
                        ),
                        verticalScrollbarStyle: const ScrollbarStyle(
                          isAlwaysShown: false,
                          thickness: 4.0,
                          radius: Radius.circular(5.0),
                        ),
                        enablePullToRefresh: true,
                        refreshIndicator: const WaterDropHeader(),
                        onRefresh: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          getTransactionHistory();
                        },
                        htdRefreshController: _hdtRefreshController,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      SizedBox(),
      Container(
        width: 110,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          child: _getTitleItemWidget('Date' + (sortType == date ? (isAscending ? '↓' : '↑') : '')),
          onPressed: () {
            sortType = date;
            isAscending = !isAscending;
            sortDate(isAscending);
            setState(() {});
          },
        ),
      ),
      Expanded(
        flex: 3,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          child: _getTitleItemWidget(
              'Transaction History' + (sortType == history ? (isAscending ? '↓' : '↑') : '')),
          onPressed: () {
            sortType = history;
            isAscending = !isAscending;
            sortHistory(isAscending);
            setState(() {});
          },
        ),
      ),
      Expanded(
        flex: 2,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          child:
              _getTitleItemWidget('Coins' + (sortType == coins ? (isAscending ? '↓' : '↑') : '')),
          onPressed: () {
            sortType = coins;
            isAscending = !isAscending;
            sortCoins(isAscending);
            setState(() {});
          },
        ),
      ),
    ];
  }

  Widget _getTitleItemWidget(String label) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Text(label, style: TextStyle(fontFamily: 'MontserratBold')),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: [
        Container(
          width: 110,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(getDate(transactions[index].created_at),
                style: TextStyle(fontFamily: 'MontserratBold')),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(transactions[index].transaction_type,
                style: TextStyle(fontFamily: 'MontserratBold')),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(numberFormatter(transactions[index].transaction_value),
                style: TextStyle(fontFamily: 'MontserratBold')),
          ),
        ),
      ],
    );
  }

  ///
  /// Single sort, sort Name's id
  void sortDate(bool isAscending) {
    transactions.sort((a, b) {
      return isAscending
          ? a.created_at.compareTo(b.created_at)
          : b.created_at.compareTo(a.created_at);
    });
  }

  ///
  /// sort with Status and Name as the 2nd Sort
  void sortHistory(bool isAscending) {
    transactions.sort((a, b) {
      return isAscending
          ? a.transaction_type.toLowerCase().compareTo(b.transaction_type.toLowerCase())
          : b.transaction_type.toLowerCase().compareTo(a.transaction_type.toLowerCase());
    });
  }

  ///
  /// sort with Status and Name as the 2nd Sort
  void sortCoins(bool isAscending) {
    transactions.sort((a, b) {
      return isAscending
          ? a.transaction_value - b.transaction_value
          : b.transaction_value - a.transaction_value;
    });
  }
}

class BackNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            'assets/icon/left-arrow.png',
            height: 20,
          ),
        ),
        Expanded(
          child: Text(
            "Back",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'MontserratExtraBold',
              fontSize: 16.0,
              color: Common.orange_color,
            ),
          ),
        ),
      ],
    );
  }
}
