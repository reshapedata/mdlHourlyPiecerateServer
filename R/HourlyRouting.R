

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
#' HourlyRoutingServer_upload()
HourlyRoutingServer_upload <- function(input,output,session,dms_token) {

  file_HourlyRouting=tsui::var_file('file_HourlyRouting')
  shiny::observeEvent(input$btn_HourlyRouting_upload,{

    filename=file_HourlyRouting()
    if(is.null(filename)){
      tsui::pop_notice('请选择需要上传的文件')
    }
    else{
      mdlHourlyPieceratePkg::HourlyRouting_upload(token = dms_token,file_name = filename)
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
#' HourlyRoutingServer_view()
HourlyRoutingServer_view <- function(input,output,session,dms_token) {

  text_HourlyRouting_FRoutingNumber=tsui::var_text('text_HourlyRouting_FRoutingNumber')
  shiny::observeEvent(input$btn_HourlyRouting_view,{
    FRoutingNumber=text_HourlyRouting_FRoutingNumber()

    data=mdlHourlyPieceratePkg::HourlyRouting_view(token = dms_token,FRoutingNumber =  FRoutingNumber)

    tsui::run_dataTable2(id = 'dt_HourlyRouting',data = data)
    tsui::run_download_xlsx(id = 'dl_HourlyRouting',data = data,filename = '工艺路线表.xlsx')

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
#' HourlyRoutingServer_delete()
HourlyRoutingServer_delete <- function(input,output,session,dms_token) {

  text_HourlyRouting_FRoutingNumber_delete=tsui::var_text('text_HourlyRouting_FRoutingNumber_delete')

  shiny::observeEvent(input$btn_HourlyRouting_delete,{
    FRoutingNumber=text_HourlyRouting_FRoutingNumber_delete()
    mdlHourlyPieceratePkg::HourlyRouting_delete(token = dms_token,FRoutingNumber =FRoutingNumber )

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
#' HourlyRoutingServer()
HourlyRoutingServer <- function(input,output,session,dms_token) {


  HourlyRoutingServer_upload(input=input,output=output,session=session,dms_token=dms_token)

  HourlyRoutingServer_view(input=input,output=output,session=session,dms_token=dms_token)

  HourlyRoutingServer_delete(input=input,output=output,session=session,dms_token=dms_token)

}
