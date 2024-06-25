import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cryptocurrency/components/item.dart';
import 'package:Cryptocurrency/components/item2.dart';
import 'package:Cryptocurrency/model/coinModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    getCoinMarket();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          body: cubit.user_model == null
              ? Center(child: CircularProgressIndicator())
              : SafeArea(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.yellow.shade500,
                    Colors.amber.shade200,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$ ${double.tryParse(cubit.user_model!.deposit!) ?? "N/A"}',
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Assets',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: isRefreshing
                                  ? Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xffFBC700),
                                ),
                              )
                                  : coinMarket == null ||
                                  coinMarket!.isEmpty
                                  ? Center(
                                child: Text(
                                  'No data available',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                                  : ListView.builder(
                                itemCount: coinMarket!.length,
                                shrinkWrap: true,
                                physics:
                                BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Item(
                                    item: coinMarket![index],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Recommend to Buy',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: isRefreshing
                                  ? Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xffFBC700),
                                ),
                              )
                                  : coinMarket == null ||
                                  coinMarket!.isEmpty
                                  ? Center(
                                child: Text(
                                  'No data available',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                                  : ListView.builder(
                                scrollDirection:
                                Axis.horizontal,
                                itemCount: coinMarket!.length,
                                itemBuilder: (context, index) {
                                  return Item2(
                                    item: coinMarket![index],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool isRefreshing = true;
  List? coinMarket = [];
  var coinMarketList;

  Future<void> getCoinMarket() async {
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';
    setState(() {
      isRefreshing = true;
    });
    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    setState(() {
      isRefreshing = false;
    });
    if (response.statusCode == 200) {
      var x = response.body;
      coinMarketList = coinModelFromJson(x);
      setState(() {
        coinMarket = coinMarketList;
      });
    } else {
      print(response.statusCode);
    }
  }
}
