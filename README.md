##WKTextFieldFormatter
####通过简单几行代码，自动过滤用户在textField中的不合法输入。

#####现已支持以下过滤方式：
--
* 手机号码
* 身份证号
* 数字
* 英文
* 英文+数字
* 小数
* 自行设置字符集
* 限制输入长度

--
![()](http://7xneqd.com1.z0.glb.clouddn.com/formatter.gif)
##使用方法
1. 首先，把 __WKTextFieldFormatter__ 设置为controller中的一个属性:

		@property (strong, nonatomic) WKTextFieldFormatter *formatter;

1. 用 `initWithTextField:controller:` 方法初始化 ___formatter__ :
	
		_formatter = [[WKTextFieldFormatter alloc] initWithTextField:_textField controller:self];

1. 设置 ___formatter__ 的 __formatterType__ :

		typedef enum : NSUInteger {
			WKFormatterTypeALL,						//不进行过滤
			WKFormatterTypePhoneNumber,				//11位数字
			WKFormatterTypeNumber,					//任何数字
			WKFormatterTypeDecimal,					//小数,默认精确到1位小数
			WKFormatterTypeEnglishAlphabet,			//任何英文字母
		   	WKFormatterTypeNumberAndEnglishAlphabet,//数字和英文字母
		   	WKFormatterTypeCustom					//自行设置需要过滤的字符集
		} WKFormatterType;

	例如:

		_formatter.formatterType = WKFormatterTypePhoneNumber;
		
__搞定咯。__

##自行设置字符集
除了选择 __WKFormatterTypeCustom__ , 还要把 __characterSet__ 设置为你想要的字符集，例如：
 
```
_formatter.characterSet = @"iWant";
```

##限制输入长度
设置 __limitedLength__ 即可：

```
_formatter.limitedLength = 8;
```

##小数精确度
默认精确到小数点后一位，可自行设置 __decimalPlace__ ：

```
_formatter.decimalPlace = 2;
```

##注意
* 当使用了 __WKTextFieldFormatter__, 你不应再自行设置textField的delegate。
* 如果想获得用户当前输入的字符，可以遵循 __WKTextFieldFormatterDelegate__, 然后实现方法: __didEnterCharacter:currentString:__
* 更多详情，请看demo. :)

##License
WKTextFieldFormatter is released under [__MIT License__](https://github.com/WelkinXie/WKTextFieldFormatter/blob/master/LICENSE).