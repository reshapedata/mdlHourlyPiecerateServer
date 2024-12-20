

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
#' HandywagesServer_upload()
HandywagesServer_upload <- function(input,output,session,dms_token) {


  text_Handywages_FYEAR = tsui::var_text('text_Handywages_FYEAR')

  text_Handywages_FMONTH = tsui::var_text('text_Handywages_FMONTH')
  text_Handywages_FNAME = tsui::var_text('text_Handywages_FNAME')
  text_Handywages_BASEWAGES = tsui::var_text('text_Handywages_BASEWAGES')

  text_Handywages_FattendanceDays = tsui::var_text('text_Handywages_FattendanceDays')
  text_Handywages_FleaveDays = tsui::var_text('text_Handywages_FleaveDays')


  shiny::observeEvent(input$btn_Handywages_upload,{

    FYEAR=text_Handywages_FYEAR()
    FMONTH = text_Handywages_FMONTH()
    FNAME = text_Handywages_FNAME()
    FBaseWages = text_Handywages_BASEWAGES()
    FattendanceDays = text_Handywages_FattendanceDays()
    FleaveDays =text_Handywages_FleaveDays()

      mdlHourlyPieceratePkg::Handywages_upload(dms_token =dms_token ,FYEAR =FYEAR ,FMONTH = FMONTH,FNAME =FNAME
                                               ,FBaseWages = FBaseWages,FattendanceDays =FattendanceDays ,FleaveDays = FleaveDays)



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
#' HandywagesServer_view()
HandywagesServer_view <- function(input,output,session,dms_token) {

  text_Handywages_fname_view=tsui::var_text('text_Handywages_fname_view')
  shiny::observeEvent(input$btn_Handywages_view,{
    FNAME=text_Handywages_fname_view()

    data=mdlHourlyPieceratePkg::Handywages_view(dms_token = dms_token,FNAME =  FNAME)

    tsui::run_dataTable2(id = 'dt_Handywages',data = data)
    tsui::run_download_xlsx(id = 'dl_Handywages',data = data,filename = '杂工工资信息表.xlsx')

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
#' HandywagesServer_delete()
HandywagesServer_delete <- function(input,output,session,dms_token) {

  text_Handywages_FID_delete=tsui::var_text('text_Handywages_FID_delete')

  shiny::observeEvent(input$btn_Handywages_delete,{
    FID=text_Handywages_FID_delete()
    mdlHourlyPieceratePkg::Handywages_delete(dms_token = dms_token,FID =FID )

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
#' HandywagesServer()
HandywagesServer <- function(input,output,session,dms_token) {


  HandywagesServer_upload(input=input,output=output,session=session,dms_token=dms_token)

  HandywagesServer_view(input=input,output=output,session=session,dms_token=dms_token)

  HandywagesServer_delete(input=input,output=output,session=session,dms_token=dms_token)

}
