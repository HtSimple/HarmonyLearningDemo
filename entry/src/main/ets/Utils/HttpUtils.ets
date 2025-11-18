import http from '@ohos.net.http';
class HttpUtils{

  getHttpPromise(){
    return new Promise<string>((resolve,reject)=> {
      let request = http.createHttp();
      let url = ""
      let result = request.request(url);

      result.then((res)=>{
        if(res.result === 200){
          console.log("httpRequestSucceed")
        }
      })
    })
  }
}

export default new HttpUtils()  as HttpUtils


//schedule.ets文件导入HttpUtils示例   import HttpUtils from '../Utils/HttpUtils'