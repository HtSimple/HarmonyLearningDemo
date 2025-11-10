import { preferences } from '@kit.ArkData';
import hilog from '@ohos.hilog';
import { BusinessError } from '@kit.BasicServicesKit';

const TAG = 'PreferencesUtils';
const KEY_APP_FONT_SIZE= 'appFontSize';

export  class  PreferencesUtils{
  static readonly TAG = 'PreferencesUtils';

  preference?: preferences.Preferences;

  getFontPreferences(context:Context){
    this.preference = preferences.getPreferencesSync(context ,{name : 'FontPreferences'});
    hilog.info(0x0000,TAG,'create success');
  }

  getChangeFontSize(){
    let fontSizeOffset : number =0;
    fontSizeOffset = this.preference?.getSync(KEY_APP_FONT_SIZE,0) as number;
    return fontSizeOffset;
  }

  saveChangeFontSize(fontSizeOffset : number){
    this.preference?.putSync(KEY_APP_FONT_SIZE,fontSizeOffset);
    this.preference?.flush(
      (err: BusinessError) =>{
        if(err){
          hilog.error(0x0000,TAG,'Failed to flush. code ='+err.code+', message ='+err.message);
          return;
        }
        hilog.info(0x0000,TAG,'Succeeded in flushing.');
      }
    )
  }
}