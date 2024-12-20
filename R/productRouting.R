

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
#' productRoutingServer_upload()
productRoutingServer_upload <- function(input,output,session,dms_token) {

  file_productRouting=tsui::var_file('file_productRouting')
  shiny::observeEvent(input$btn_productRouting_upload,{

    filename=file_productRouting()
    if(is.null(filename)){
      tsui::pop_notice('请选择需要上传的文件')
    }
    else{
      mdlHourlyPieceratePkg::productRouting_upload(token = dms_token,file_name = filename)
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
#' productRoutingServer_view()
productRoutingServer_view <- function(input,output,session,dms_token) {

  text_productRouting_FSpecification=tsui::var_text('text_productRouting_FSpecification')
  shiny::observeEvent(input$btn_productRouting_view,{
    FSpecification=text_productRouting_FSpecification()

    data=mdlHourlyPieceratePkg::productRouting_view(token = dms_token,FSpecification =FSpecification )

    tsui::run_dataTable2(id = 'dt_productRouting',data = data)
    tsui::run_download_xlsx(id = 'dl_productRouting',data = data,filename = '产品工艺路线表.xlsx')

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
#' productRoutingServer_delete()
productRoutingServer_delete <- function(input,output,session,dms_token) {

  text_productRouting_FSpecification_delete=tsui::var_text('text_productRouting_FSpecification_delete')

  shiny::observeEvent(input$btn_productRouting_delete,{
    FSpecification=text_productRouting_FSpecification_delete()
    mdlHourlyPieceratePkg::productRouting_delete(token = dms_token,FSpecification = FSpecification )

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
#' productRoutingServer()
productRoutingServer <- function(input,output,session,dms_token) {


  productRoutingServer_upload(input=input,output=output,session=session,dms_token=dms_token)

  productRoutingServer_view(input=input,output=output,session=session,dms_token=dms_token)

  productRoutingServer_delete(input=input,output=output,session=session,dms_token=dms_token)

}
