

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
#' HourlyWagesServer_upload()
HourlyWagesServer_upload <- function(input,output,session,dms_token) {

  file_HourlyWages=tsui::var_file('file_HourlyWages')
  shiny::observeEvent(input$btn_HourlyWages_upload,{

    filename=file_HourlyWages()
    if(is.null(filename)){
      tsui::pop_notice('请选择需要上传的文件')
    }
    else{
      mdlHourlyPieceratePkg::HourlyWages_upload(token = dms_token,file_name = filename)
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
#' HourlyWagesServer_view()
HourlyWagesServer_view <- function(input,output,session,dms_token) {

  text_HourlyWages_FOPERATIONNAME=tsui::var_text('text_HourlyWages_FOPERATIONNAME')
  shiny::observeEvent(input$btn_HourlyWages_view,{
    FOPERATIONNAME=text_HourlyWages_FOPERATIONNAME()

    data=mdlHourlyPieceratePkg::HourlyWages_view(token = dms_token,FOPERATIONNAME = FOPERATIONNAME )

    tsui::run_dataTable2(id = 'dt_HourlyWages',data = data)
    tsui::run_download_xlsx(id = 'dl_HourlyWages',data = data,filename = '工序工资模板表.xlsx')

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
#' HourlyWagesServer_delete()
HourlyWagesServer_delete <- function(input,output,session,dms_token) {

  text_HourlyWages_FOPERATIONNAMEFSEQ_delete=tsui::var_text('text_HourlyWages_FOPERATIONNAMEFSEQ_delete')

  shiny::observeEvent(input$btn_HourlyWages_delete,{
    FOPERATIONNAMEFSEQ=text_HourlyWages_FOPERATIONNAMEFSEQ_delete()
    mdlHourlyPieceratePkg::HourlyWages_delete(token = dms_token,FOPERATIONNAMEFSEQ = FOPERATIONNAMEFSEQ)

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
#' HourlyWagesServer()
HourlyWagesServer <- function(input,output,session,dms_token) {


  HourlyWagesServer_upload(input=input,output=output,session=session,dms_token=dms_token)

  HourlyWagesServer_view(input=input,output=output,session=session,dms_token=dms_token)

  HourlyWagesServer_delete(input=input,output=output,session=session,dms_token=dms_token)

}
