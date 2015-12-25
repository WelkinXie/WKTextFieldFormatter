##WKTextFieldFormatter
####WKTextFieldFormatter can easily block the unwanted input to the textField.

![()](http://7xneqd.com1.z0.glb.clouddn.com/format.gif)

1. Set __WKTextFieldFormatter__ as a property in controller:

		@property (strong, nonatomic) WKTextFieldFormatter *textFieldFormatter;

1. Initialize __WKTextFieldFormatter__ with method `initWithTextField:`:
	
		_textFieldFormatter = [[WKTextFieldFormatter alloc] initWithTextField:textField];

1. Then give the property __formatterType__ a value below:

		typedef enum : NSUInteger {
			WKFormatterTypeALL,						//allow any characters
			WKFormatterTypePhoneNumber,				//11 * (0~9)
			WKFormatterTypeNumber,					//(0~9)
			WKFormatterTypeEnglishAlphabet,			//(a~z),(A~Z)
		   	WKFormatterTypeNumberAndEnglishAlphabet,//(0~9),(a~z),(A~Z)
		   	WKFormatterTypeCustom					//only your wanted characters
		} WKFormatterType;

	like this:

		_textFieldFormatter.formatterType = WKFormatterTypePhoneNumber;


---
When you choose __WKFormatterTypeCustom__ , set the value of __characterSet__ with characters you want at the same time.
```
_textFieldFormatter.characterSet = @"iWant";
```

###Also set the <a> limitedLength </a> if you want to limit the length of input.
```
_textFieldFormatter.limitedLength = 8;
```

##Attention
* When using __WKTextFieldFormatter__, you should not set the delegate of the textField manually, because it has been set when __WKTextFieldFormatter__ initializes.

##License
WKTextFieldFormatter is released under [__MIT License__](https://github.com/WelkinXie/WKTextFieldFormatter/blob/master/LICENSE).