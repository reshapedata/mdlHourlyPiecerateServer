#' 预览
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
#' HourlyPieceServer_preview()
HourlyPieceServer_preview <- function(input,output,session,dms_token) {

  file_HourlyPiece=tsui::var_file('file_HourlyPiece')
shiny::observeEvent(input$btn_HourlyPiece_pre,{

  filename=file_HourlyPiece()
  if(is.null(filename)){
    tsui::pop_notice('请上传需要预览的文件')
  }
  else{

    data=mdlHourlyPieceratePkg::HourlyPiecerate_preview(token = dms_token,file_name = filename)

    tsui::run_dataTable2(id = 'dt_HourlyPiece',data = data)

  }
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
#' HourlyPieceServer_upload()
HourlyPieceServer_upload <- function(input,output,session,dms_token) {

  file_HourlyPiece=tsui::var_file('file_HourlyPiece')
  shiny::observeEvent(input$btn_HourlyPiece_upload,{

    filename=file_HourlyPiece()
    if(is.null(filename)){
      tsui::pop_notice('请选择需要上传的文件')
    }
    else{
      mdlHourlyPieceratePkg::HourlyPiecerate_upload(token = dms_token,file_name = filename)
      tsui::pop_notice("上传成功")

    }
  })
}

#' 按单据编号查询
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
#' HourlyPieceServer_view()
HourlyPieceServer_view <- function(input,output,session,dms_token) {

  text_HourlyPiece_FBillno=tsui::var_text('text_HourlyPiece_FBillno')
  shiny::observeEvent(input$btn_HourlyPiece_view,{
    FProductionNumber=text_HourlyPiece_FBillno()
    data=mdlHourlyPieceratePkg::HourlyPiecerate_view(token = dms_token,FProductionNumber = FProductionNumber )


    tsui::run_dataTable2(id = 'dt_HourlyPiece',data = data)

  })
}
#' 按下载数据
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
#' HourlyPieceServer_download()
HourlyPieceServer_download <- function(input,output,session,dms_token) {

  date=mdlHourlyPieceratePkg::HourlyPiecerate_viewAll(token = dms_token)

  data=mdlHourlyPieceratePkg::HourlyPiecerate_viewAll(token = dms_token)

  tsui::run_download_xlsx(id = 'dl_HourlyPiece',data = data,filename = '计时计件工资表.xlsx')

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
#' HourlyPieceServer_delete()
HourlyPieceServer_delete <- function(input,output,session,dms_token) {

  text_HourlyPiece_FBillno_delete=tsui::var_text('text_HourlyPiece_FBillno_delete')
  text_HourlyPiece_Fseq_delete=tsui::var_text('text_HourlyPiece_Fseq_delete')

  shiny::observeEvent(input$btn_HourlyPiece_delete,{
    FProductionNumber=text_HourlyPiece_FBillno_delete()
    Fseq=text_HourlyPiece_Fseq_delete()
    mdlHourlyPieceratePkg::HourlyPiecerate_delete(token = dms_token,FProductionNumber = FProductionNumber,Fseq =Fseq)

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
#' HourlyPieceServer()
HourlyPieceServer <- function(input,output,session,dms_token) {


  HourlyPieceServer_preview(input=input,output=output,session=session,dms_token=dms_token)

  HourlyPieceServer_upload(input=input,output=output,session=session,dms_token=dms_token)

  HourlyPieceServer_view(input=input,output=output,session=session,dms_token=dms_token)
  HourlyPieceServer_delete(input=input,output=output,session=session,dms_token=dms_token)

  HourlyPieceServer_download(input=input,output=output,session=session,dms_token=dms_token)

}
