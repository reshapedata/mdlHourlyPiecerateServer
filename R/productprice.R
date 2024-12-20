

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
#' productpriceServer_upload()
productpriceServer_upload <- function(input,output,session,dms_token) {

  file_productprice=tsui::var_file('file_productprice')
  shiny::observeEvent(input$btn_productprice_upload,{

    filename=file_productprice()
    if(is.null(filename)){
      tsui::pop_notice('请选择需要上传的文件')
    }
    else{
      mdlHourlyPieceratePkg::productprice_upload(token = dms_token,file_name = filename)
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
#' productpriceServer_view()
productpriceServer_view <- function(input,output,session,dms_token) {

  text_productprice_FSpecification=tsui::var_text('text_productprice_FSpecification')
  shiny::observeEvent(input$btn_productprice_view,{
    FSpecification=text_productprice_FSpecification()

    data=mdlHourlyPieceratePkg::productprice_view(token = dms_token,FSpecification =FSpecification )

    tsui::run_dataTable2(id = 'dt_productprice',data = data)
    tsui::run_download_xlsx(id = 'dl_productprice',data = data,filename = '订单核价单表.xlsx')

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
#' productpriceServer_delete()
productpriceServer_delete <- function(input,output,session,dms_token) {

  text_productprice_FSpecification_delete=tsui::var_text('text_productprice_FSpecification_delete')

  shiny::observeEvent(input$btn_productprice_delete,{
    FSpecification=text_productprice_FSpecification_delete()
    mdlHourlyPieceratePkg::productprice_delete(token = dms_token,FSpecification = FSpecification )

    tsui::pop_notice('删除成功')

  })
}


#' 获取订单核价单
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
#' productpriceServer_get()
productpriceServer_get <- function(input,output,session,dms_token) {

  shiny::observeEvent(input$btn_productprice_get,{
    data = mdlHourlyPieceratePkg::productprice_get(token = dms_token)

    tsui::run_dataTable2(id = 'dt_productprice',data = data)
    tsui::run_download_xlsx(id = 'dl_productprice_get',data = data,filename = '订单核价单预处理.xlsx')

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
#' productpriceServer()
productpriceServer <- function(input,output,session,dms_token) {


  productpriceServer_upload(input=input,output=output,session=session,dms_token=dms_token)

  productpriceServer_view(input=input,output=output,session=session,dms_token=dms_token)

  productpriceServer_delete(input=input,output=output,session=session,dms_token=dms_token)
  productpriceServer_get(input=input,output=output,session=session,dms_token=dms_token)

}
