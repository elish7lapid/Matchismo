// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "SetCardGameViewController.h"

#import "Card.h"
#import "CardMatchingGame.h"
#import "SetCard.h"
#import "SetCardDeck.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardGameViewController()
// The card buttons displayed in the view.
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation SetCardGameViewController

@dynamic cardButtons;

@synthesize game = _game;

// Number of cards that are matched in one turn of the matching game.
static const NSUInteger kNumCardsToMatch = 3;

- (void)viewDidLoad {
  [super viewDidLoad];
  [self startNewGame];
}

- (void)startNewGame {
  _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                            usingDeck:[self createDeck]];
  self.game.numCardsToMatch = kNumCardsToMatch;
}

- (nullable Deck *)createDeck {
  return [[SetCardDeck alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.game.numCardsToMatch = kNumCardsToMatch;
  [super updateUI];
}

- (nullable UIImage *)backgroundImageForCard:(Card *)card {
  return [UIImage imageNamed:card.isChosen ? @"cardfrontChosen" : @"cardfront"];
}

- (void)setCardButtonContents:(UIButton *)cardButton forCard:(Card *)card {
  [cardButton setAttributedTitle:[(SetCard *)card contentsAsAtributtedString]
                        forState:UIControlStateNormal];
}

- (nullable NSMutableAttributedString *)createStringFromCardsArray:
(NSMutableArray<SetCard *> *)cardsArray {
  auto concatenatedArrayString = [[NSMutableAttributedString alloc] initWithString:@""];
  for (SetCard *cardFromArray in cardsArray) {
    [concatenatedArrayString appendAttributedString:[cardFromArray contentsAsAtributtedString]];
    [concatenatedArrayString appendAttributedString:[[NSMutableAttributedString alloc]
                                                     initWithString:@", "]];
  }
  return concatenatedArrayString;
}

@end

NS_ASSUME_NONNULL_END
