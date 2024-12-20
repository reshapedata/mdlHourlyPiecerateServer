

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

  text_HourlyPiece_FYEAR=tsui::var_text('text_HourlyPiece_FYEAR')

  text_HourlyPiece_FMONTH=tsui::var_text('text_HourlyPiece_FMONTH')
  shiny::observeEvent(input$btn_HourlyPiece_view,{
    FYEAR=text_HourlyPiece_FYEAR()

    FMONTH=text_HourlyPiece_FMONTH()
    data=mdlHourlyPieceratePkg::HourlyPiecerate_view(dms_token =dms_token ,FYEAR = FYEAR,FMONTH =FMONTH )

    tsui::run_dataTable2(id = 'dt_HourlyPiece',data = data)
    tsui::run_download_xlsx(id = 'dl_HourlyPiece',data = data,filename = '员工工资表.xlsx')

  })
}



#' 按明细查询
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
#' HourlyPieceServer_detail_view()
HourlyPieceServer_detail_view <- function(input,output,session,dms_token) {

  text_HourlyPiece_FYEAR=tsui::var_text('text_HourlyPiece_FYEAR')

  text_HourlyPiece_FMONTH=tsui::var_text('text_HourlyPiece_FMONTH')
  shiny::observeEvent(input$btn_HourlyPiece_detail_view,{
    FYEAR=text_HourlyPiece_FYEAR()

    FMONTH=text_HourlyPiece_FMONTH()
    data=mdlHourlyPieceratePkg::HourlyPiecerate_detail_view(dms_token =dms_token ,FYEAR = FYEAR,FMONTH =FMONTH )

    tsui::run_dataTable2(id = 'dt_HourlyPiece',data = data)
    tsui::run_download_xlsx(id = 'dl_HourlyPiece_detail',data = data,filename = '员工工资明细表.xlsx')

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


  HourlyPieceServer_detail_view(input=input,output=output,session=session,dms_token=dms_token)

  HourlyPieceServer_view(input=input,output=output,session=session,dms_token=dms_token)


}
