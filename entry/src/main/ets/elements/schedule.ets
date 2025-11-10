import { scheduleItem } from './scheduleItem'
import { getToday, getMonthWeeks } from './tools';
import { formatDateToString } from './tools';

interface ScheduleItemData {
  title: string;
  startTime: string;
  endTime: string;
}

@Component
export struct schedule {
  @StorageLink("titleDate") @Watch('onTitleDateChanged') titleDate: number[] = getToday();
  @State scheduleDate: string = formatDateToString(this.titleDate);
  @State weeks: number = getMonthWeeks(this.titleDate);
  // 定义日程项数据数组
  private scheduleItems: ScheduleItemData[] = [
    { title: '巡检报告填写', startTime: '00:00:00', endTime: '23:59:59' },
    { title: '设备润滑保养', startTime: '08:30:00', endTime: '09:30:00' },
    { title: '耗材库存盘点', startTime: '09:40:00', endTime: '10:10:00' },
    { title: '发电机日巡检', startTime: '10:00:00', endTime: '12:00:00' },
    { title: '应急演练准备', startTime: '11:00:00', endTime: '11:40:00' },
    { title: '废物处理', startTime: '13:00:00', endTime: '21:00:00' },
    { title: '电脑维修', startTime: '14:00:00', endTime: '20:00:00' },
    { title: '电池检查', startTime: '14:00:00', endTime: '22:00:00' },
    // { title: '安全培训会议', startTime: '15:00:00', endTime: '16:30:00' },
    // { title: '消防设施检查', startTime: '16:40:00', endTime: '17:20:00' },
    // { title: '网络设备维护', startTime: '19:00:00', endTime: '20:30:00' },
    // { title: '月度工作总结', startTime: '21:00:00', endTime: '22:30:00' }
  ];

  onTitleDateChanged(newValue: number[]) {
    this.scheduleDate = formatDateToString(this.titleDate);
    console.info('titleDate 变化为：', newValue);
    this.weeks = getMonthWeeks(this.titleDate);
  }

  build() {
    Column() {
      Text(`${this.scheduleDate}`)
        .margin({ bottom: 12 })
        .width('80%')
        .height(33)

      List({space:12}) {
        ForEach(this.scheduleItems,
          (item: ScheduleItemData) => {
            ListItem() {
              scheduleItem({
                title: item.title,
                startTime: `${this.scheduleDate} ${item.startTime}`,
                endTime: `${this.scheduleDate} ${item.endTime}`
              })
            }
            .width('100%')
          }, (item: ScheduleItemData) => JSON.stringify(item))
      }
      .width('100%')
      .scrollBar(BarState.On)
      .layoutWeight(1)
    }
  }
}