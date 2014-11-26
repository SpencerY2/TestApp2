//
//  LtSupportedLocales.m
//  Lutino
//
//  Created by Spencer Yeh on 11/2/13.
//  Copyright (c) 2013 Yeh Technology. All rights reserved.
//

#import "LtSupportedLocales.h"
#import "LtOptions.h"
//#import "LtRecognizing.h"
#import "LtRecognizerFactory.h"
#import "LtTranslating.h"
#import "LtTranslatorFactory.h"
#import "LtVocalizing.h"
#import "LtVocalizerFactory.h"
#import "LtLocale.h"

@implementation LtSupportedLocales
{
    id <LtRecognizing> m_Recognizer;
    NSString *m_RecognizerName;
    id <LtTranslating> m_Translator;
    NSString *m_TranslatorName;
    id <LtVocalizing> m_Vocalizer;
    NSString *m_VocalizerName;

}

@synthesize recognitionLocaleCodes;
@synthesize translationLocales;
@synthesize vocalizationLocaleCodes;

+ (LtSupportedLocales *)instance {
    static dispatch_once_t once;
    static LtSupportedLocales * sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        [sharedInstance loadLocales:nil withRecognizer:nil andVocalizer:nil];
    });
    return sharedInstance;
}

+ (void) refresh
{
    [self refresh:nil withRecognizer:nil andVocalizer:nil];
}

+ (void) refresh: (NSString *)translatorName
{
    [self refresh:translatorName withRecognizer:nil andVocalizer:nil];
}

+ (void) refresh: (NSString *)translatorName withRecognizer:(NSString *)recognizerName andVocalizer:(NSString *)vocalizerName
{
    [[self instance] loadLocales:translatorName withRecognizer:recognizerName andVocalizer:vocalizerName];
}

- (void)loadLocales: (NSString *)translatorName withRecognizer:(NSString *)recognizerName andVocalizer:(NSString *)vocalizerName
{
    // Translation Locales
    if (translatorName == nil)
    {
        translatorName = LtOptions.instance.translator;
    }
    if (m_Translator == nil || ![m_TranslatorName isEqualToString:translatorName])
    {
        m_TranslatorName = translatorName;
        m_Translator = [LtTranslatorFactory getTranslator:translatorName];
        
        translationLocales = [NSMutableArray arrayWithCapacity:100];
        for (NSString *localeCode in [m_Translator supportedLocaleCodes])
        {
            [translationLocales addObject:[[LtLocale alloc] initWithLocaleCode:localeCode]];
        }
    }
    
    // Recognition locales
    if (recognizerName == nil)
    {
        recognizerName = LtOptions.instance.recognizer;
    }
    if (m_Recognizer == nil || ![m_RecognizerName isEqualToString:recognizerName])
    {
        m_RecognizerName = recognizerName;
        m_Recognizer = [LtRecognizerFactory getRecognizer:recognizerName];
        recognitionLocaleCodes = [m_Recognizer supportedLocaleCodes];
    }
    
    // Vocalization locales
    if (vocalizerName == nil)
    {
        vocalizerName = LtOptions.instance.vocalizer;
    }
    if (m_Vocalizer == nil || ![m_VocalizerName isEqualToString:vocalizerName])
    {
        m_VocalizerName = vocalizerName;
        m_Vocalizer = [LtVocalizerFactory getVocalizer:vocalizerName];
        vocalizationLocaleCodes = [m_Vocalizer supportedLocaleCodes];
    }
}

@end
