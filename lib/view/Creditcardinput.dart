import 'package:Cryptocurrency/components/done_button.dart';
import 'package:Cryptocurrency/constants/captions.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:Cryptocurrency/components/back_card_view.dart';
import 'package:Cryptocurrency/components/front_card_view.dart';
import 'package:Cryptocurrency/components/input_view_pager.dart';
import 'package:Cryptocurrency/components/round_button.dart';
import 'package:Cryptocurrency/constants/constanst.dart';
import 'package:Cryptocurrency/model/card_info.dart';
import 'package:Cryptocurrency/provider/card_cvv_provider.dart';
import 'package:Cryptocurrency/provider/card_name_provider.dart';
import 'package:Cryptocurrency/provider/card_number_provider.dart';
import 'package:Cryptocurrency/provider/card_valid_provider.dart';
import 'package:Cryptocurrency/provider/state_provider.dart';
import 'package:provider/provider.dart';

typedef CardInfoCallback = void Function(InputState currentState, CardInfo cardInfo);

class CreditCardInputForm extends StatelessWidget {
  CreditCardInputForm({
    this.onStateChange,
    this.cardHeight,
    this.frontCardDecoration,
    this.backCardDecoration,
    this.showDoneButton = true,
    this.customCaptions,
    this.cardNumber = '',
    this.cardName = '',
    this.cardCVV = '',
    this.cardValid = '',
    this.initialAutoFocus = true,
    this.initialCardState = InputState.NUMBER,
    this.nextButtonTextStyle = kDefaultButtonTextStyle,
    this.prevButtonTextStyle = kDefaultButtonTextStyle,
    this.doneButtonTextStyle = kDefaultButtonTextStyle,
    this.nextButtonDecoration = defaultNextPrevButtonDecoration,
    this.prevButtonDecoration = defaultNextPrevButtonDecoration,
    this.resetButtonDecoration = defaultResetButtonDecoration,
  });

  final Function? onStateChange;
  final double? cardHeight;
  final BoxDecoration? frontCardDecoration;
  final BoxDecoration? backCardDecoration;
  final bool showDoneButton;
  final Map<String, String>? customCaptions;
  final BoxDecoration nextButtonDecoration;
  final BoxDecoration prevButtonDecoration;
  final BoxDecoration resetButtonDecoration;
  final TextStyle nextButtonTextStyle;
  final TextStyle prevButtonTextStyle;
  final TextStyle doneButtonTextStyle;
  final String cardNumber;
  final String cardName;
  final String cardCVV;
  final String cardValid;
  final bool initialAutoFocus;
  final InputState initialCardState;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StateProvider(initialCardState),
        ),
        ChangeNotifierProvider(
          create: (context) => CardNumberProvider(cardNumber),
        ),
        ChangeNotifierProvider(
          create: (context) => CardNameProvider(cardName),
        ),
        ChangeNotifierProvider(
          create: (context) => CardValidProvider(cardValid),
        ),
        ChangeNotifierProvider(
          create: (context) => CardCVVProvider(cardCVV),
        ),
        Provider(
          create: (_) => Captions(customCaptions: customCaptions),
        ),
      ],
      child: CreditCardInputImpl(
        onCardModelChanged: onStateChange as void Function(InputState, CardInfo)?,
        backDecoration: backCardDecoration,
        frontDecoration: frontCardDecoration,
        cardHeight: cardHeight,
        initialAutoFocus: initialAutoFocus,
        showDoneButton: showDoneButton,
        prevButtonDecoration: prevButtonDecoration,
        nextButtonDecoration: nextButtonDecoration,
        resetButtonDecoration: resetButtonDecoration,
        prevButtonTextStyle: prevButtonTextStyle,
        nextButtonTextStyle: nextButtonTextStyle,
        resetButtonTextStyle: doneButtonTextStyle,
        initialCardState: initialCardState,
      ),
    );
  }
}

class CreditCardInputImpl extends StatefulWidget {
  final CardInfoCallback? onCardModelChanged;
  final double? cardHeight;
  final BoxDecoration? frontDecoration;
  final BoxDecoration? backDecoration;
  final bool? showDoneButton;
  final BoxDecoration? nextButtonDecoration;
  final BoxDecoration? prevButtonDecoration;
  final BoxDecoration? resetButtonDecoration;
  final TextStyle? nextButtonTextStyle;
  final TextStyle? prevButtonTextStyle;
  final TextStyle? resetButtonTextStyle;
  final InputState? initialCardState;
  final bool? initialAutoFocus;

  CreditCardInputImpl({
    this.onCardModelChanged,
    this.cardHeight,
    this.showDoneButton,
    this.frontDecoration,
    this.backDecoration,
    this.nextButtonTextStyle,
    this.prevButtonTextStyle,
    this.resetButtonTextStyle,
    this.nextButtonDecoration,
    this.prevButtonDecoration,
    this.initialCardState,
    this.initialAutoFocus,
    this.resetButtonDecoration,
  });

  @override
  _CreditCardInputImplState createState() => _CreditCardInputImplState();
}

class _CreditCardInputImplState extends State<CreditCardInputImpl> {
  PageController? pageController;
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  final cardHorizontalpadding = 12;
  final cardRatio = 16.0 / 9.0;
  var _currentState;

  @override
  void initState() {
    super.initState();
    _currentState = widget.initialCardState;
    pageController = PageController(
      viewportFraction: 0.92,
      initialPage: widget.initialCardState!.index,
    );
  }

  @override
  Widget build(BuildContext context) {
    final newState = Provider.of<StateProvider>(context).getCurrentState();
    final name = Provider.of<CardNameProvider>(context).cardName;
    final cardNumber = Provider.of<CardNumberProvider>(context).cardNumber;
    final valid = Provider.of<CardValidProvider>(context).cardValid;
    final cvv = Provider.of<CardCVVProvider>(context).cardCVV;
    final captions = Provider.of<Captions>(context);

    if (newState != _currentState) {
      _currentState = newState;

      Future(() {
        widget.onCardModelChanged!(
          _currentState,
          CardInfo(name: name, cardNumber: cardNumber, validate: valid, cvv: cvv),
        );
      });
    }

    double cardWidth =
        MediaQuery.of(context).size.width - (2 * cardHorizontalpadding);
    double? cardHeight;
    if (widget.cardHeight != null && widget.cardHeight! > 0) {
      cardHeight = widget.cardHeight;
    } else {
      cardHeight = cardWidth / cardRatio;
    }

    final frontDecoration = widget.frontDecoration ?? defaultCardDecoration;
    final backDecoration = widget.backDecoration ?? defaultCardDecoration;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: FlipCard(
                speed: 300,
                flipOnTouch: _currentState == InputState.DONE,
                key: cardKey,
                front: FrontCardView(
                  height: cardHeight,
                  decoration: frontDecoration,
                ),
                back: BackCardView(
                  height: cardHeight,
                  decoration: backDecoration,
                ),
              ),
            ),
            Stack(
              children: [
                AnimatedOpacity(
                  opacity: _currentState == InputState.DONE ? 0 : 1,
                  duration: Duration(milliseconds: 500),
                  child: InputViewPager(
                    isAutoFoucus: widget.initialAutoFocus!,
                    pageController: pageController,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: AnimatedOpacity(
                    opacity: widget.showDoneButton! && _currentState == InputState.DONE ? 1 : 0,
                    duration: Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DoneButton(
                        decoration: widget.resetButtonDecoration!,
                        textStyle: widget.resetButtonTextStyle!,
                        onTap: () {
                          if (!widget.showDoneButton!) {
                            return;
                          }
                          Provider.of<StateProvider>(context, listen: false).moveFirstState();
                          pageController!.animateToPage(
                            0,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );

                          if (!cardKey.currentState!.isFront) {
                            cardKey.currentState!.toggleCard();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                AnimatedOpacity(
                  opacity: _currentState == InputState.NUMBER || _currentState == InputState.DONE ? 0 : 1,
                  duration: Duration(milliseconds: 500),
                  child: RoundButton(
                    decoration: widget.prevButtonDecoration!,
                    textStyle: widget.prevButtonTextStyle!,
                    buttonTitle: captions.getCaption('PREV'),
                    onTap: () {
                      if (InputState.DONE == _currentState) {
                        return;
                      }
                      if (InputState.NUMBER != _currentState) {
                        pageController!.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                      if (InputState.CVV == _currentState) {
                        cardKey.currentState!.toggleCard();
                      }
                      Provider.of<StateProvider>(context, listen: false).movePrevState();
                    },
                  ),
                ),
                SizedBox(width: 10),
                AnimatedOpacity(
                  opacity: _currentState == InputState.DONE ? 0 : 1,
                  duration: Duration(milliseconds: 500),
                  child: RoundButton(
                    decoration: widget.nextButtonDecoration!,
                    textStyle: widget.nextButtonTextStyle!,
                    buttonTitle: _currentState == InputState.CVV || _currentState == InputState.DONE
                        ? captions.getCaption('DONE')
                        : captions.getCaption('NEXT'),
                    onTap: () {
                      if (InputState.CVV != _currentState) {
                        pageController!.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                      if (InputState.VALIDATE == _currentState) {
                        cardKey.currentState!.toggleCard();
                      }
                      Provider.of<StateProvider>(context, listen: false).moveNextState();
                    },
                  ),
                ),
                SizedBox(width: 25),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
