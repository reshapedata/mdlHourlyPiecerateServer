#' 同步数据
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' productdailyServer_erpsync()
productdailyServer_erpsync <- function(input,output,session,dms_token,erp_token) {

  text_productdaily_FYEAR= tsui::var_text("text_productdaily_FYEAR")
  text_productdaily_FMONTH = tsui::var_text("text_productdaily_FMONTH")
  shiny::observeEvent(input$btn_productdaily_erpsync,{

    FYEAR=text_productdaily_FYEAR()
    FMONTH = text_productdaily_FMONTH()

    if(FYEAR == '' || FMONTH ==''){
      tsui::pop_notice('年份和月份信息不能为空')
    }
    else{
      mdlHourlyPieceratePkg::productdaily_erpsync(erp_token = erp_token,dms_token = dms_token,FYEAR = FYEAR,FMONTH =FMONTH )


    }
  })
}


#' 获取工序生产日报
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' productdailyServer_get()
productdailyServer_get <- function(input,output,session,dms_token) {

  shiny::observeEvent(input$btn_productdaily_get,{
    data = mdlHourlyPieceratePkg::productdaily_get(dms_token = dms_token)
    tsui::run_dataTable2(id = 'dt_productdaily',data = data)
    tsui::run_download_xlsx(id = 'dl_productdaily_get',data = data,filename = '工序生产日报预处理.xlsx')

  })
}


#' 上传
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' productdailyServer_upload()
productdailyServer_upload <- function(input,output,session,dms_token) {

  file_productdaily=tsui::var_file('file_productdaily')
  shiny::observeEvent(input$btn_productdaily_upload,{

    filename=file_productdaily()
    if(is.null(filename)){
      tsui::pop_notice('请选择需要上传的文件')
    }
    else{
      mdlHourlyPieceratePkg::productdaily_upload(dms_token = dms_token,file_name =filename )
      tsui::pop_notice("上传成功")

    }
  })
}

#' 按工序名称查询
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' productdailyServer_view()
productdailyServer_view <- function(input,output,session,dms_token) {

  text_productdaily_FProductLots=tsui::var_text('text_productdaily_FProductLots')
  shiny::observeEvent(input$btn_productdaily_view,{
    FProductLots=text_productdaily_FProductLots()

    data = mdlHourlyPieceratePkg::productdaily_view(dms_token =dms_token ,FProductLots = FProductLots)

    tsui::run_dataTable2(id = 'dt_productdaily',data = data)
    tsui::run_download_xlsx(id = 'dl_productdaily',data = data,filename = '工序生产日报表.xlsx')

  })
}


#' 按单据编号和行号删除
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' productdailyServer_delete()
productdailyServer_delete <- function(input,output,session,dms_token) {

  text_productdaily_FSPECIFICATION_delete=tsui::var_text('text_productdaily_FSPECIFICATION_delete')

  text_productdaily_FProductLots_delete=tsui::var_text('text_productdaily_FProductLots_delete')

  shiny::observeEvent(input$btn_productdaily_delete,{
    FProductLots=text_productdaily_FProductLots_delete()
    mdlHourlyPieceratePkg::productdaily_delete(dms_token = dms_token,FProductLots =  FProductLots)

    tsui::pop_notice('删除成功')

  })
  #按图号删除
  shiny::observeEvent(input$btn_productdaily_FSPECIFICATION_delete,{
    FSPECIFICATION=text_productdaily_FSPECIFICATION_delete()
    mdlHourlyPieceratePkg::productdaily_FSPECIFICATION_delete(dms_token = dms_token,FSPECIFICATION = FSPECIFICATION)

    tsui::pop_notice('删除成功')

  })
}

#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' productdailyServer()
productdailyServer <- function(input,output,session,dms_token,erp_token) {

  productdailyServer_erpsync(input=input,output=output,session=session,dms_token=dms_token,erp_token = erp_token)
  productdailyServer_get(input=input,output=output,session=session,dms_token=dms_token)
  productdailyServer_upload(input=input,output=output,session=session,dms_token=dms_token)

  productdailyServer_view(input=input,output=output,session=session,dms_token=dms_token)

  productdailyServer_delete(input=input,output=output,session=session,dms_token=dms_token)

}
