import promptAction from '@ohos.promptAction'

// ===== 类型定义区 =====

// 文字样式接口
interface TextStyle {
  FontColor: ResourceColor
  FontSize: Length
  FontWeight: FontWeight
  Height: Length
}

// 日期颜色样式接口
interface FontColorSet {
  accentColor: ResourceColor
  defaultColor: ResourceColor
  unableColor: ResourceColor
}

// 背景颜色样式接口
interface BackgroundColorSet {
  defaultColor : ResourceColor
  unableColor : ResourceColor
}

// 日期样式接口
interface IDateStyle {
  FontColor: FontColorSet
  BackgroundColor: ResourceColor
  FontSize: Length
  FontWeight: FontWeight
  BorderWidth: Length
}

//日程样式接口
interface ICalendarStyle {
  FontColor:FontColorSet
  BackgroundColor : BackgroundColorSet
  FontSize :Length
  FontWeight:FontWeight
  Width:Length
  Height:Length
}

// 动画参数接口
interface AnimateParam {
  duration: number
  curve: Curve
}



// ===== 样式常量定义区 =====

// 标题样式
export const TitleStyle: TextStyle = {
  FontColor: Color.Black,
  FontSize: 24,
  FontWeight: FontWeight.Bold,
  Height: 24
}

// 副标题样式
export const SubTitleStyle: TextStyle = {
  FontColor: Color.Gray,
  FontSize: 15,
  FontWeight: FontWeight.Regular,
  Height: 15
}

// 日期样式
export const DateStyle: IDateStyle = {
  FontColor: {
    accentColor: '#4088FF' ,
    defaultColor: Color.Black,
    unableColor: Color.Gray
  },
  BackgroundColor: '#4088FF',
  FontSize: 14,
  FontWeight: FontWeight.Normal,
  BorderWidth: 2
}

export const calendarItemStyle : ICalendarStyle = {
  FontColor:{
    accentColor:"#4088FF",
    defaultColor:"#333333",
    unableColor:"#999999"
  },
  BackgroundColor :{
    defaultColor:"#EAF2FF",
    unableColor:"#F3F4F5"
  },
  FontSize : 16,
  FontWeight:FontWeight.Normal,
  Width : "90%",
  Height: 84
}

// 其他常量
export const BackgroundColor: ResourceColor = Color.White
export const ItemHeight: number = 42
export const ItemSpace: number = 80

// 动画样式
export const Animate: AnimateParam = {
  duration: 300,
  curve: Curve.EaseInOut
}

// ===== 回调函数 =====
export function callback(date: Date): void {
  promptAction.showToast({
    message: '选择日期：' + `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`,
    duration: 1000,
  })
}
