{include file='admin/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            签到日志
            <small>CheckIn Log</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div id="msg-success" class="alert alert-info alert-dismissable" style="display: none;">
                    <button type="button" class="close" id="ok-close" aria-hidden="true">&times;</button>
                    <h4><i class="icon fa fa-info"></i> 成功!</h4>
                    <p id="msg-success-p"></p>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="box">
                    <div class="box-body table-responsive no-padding">
                        <div class="row">
                            <div class="col-xs-7">
                                {$logs->render()}
                            </div>
                            <div class="col-xs-5 form-inline pagination">
                                <button class="btn btn-danger btn-sm" id="cleanlog">清空记录</button>
                            </div>
                        </div>
                        <table class="table table-hover">
                            <tr>
                                <th>ID</th>
                                <th>用户</th>
                                <th>用户名</th>
                                <th>获得流量</th>
                                <th>签到时间</th>
                            </tr>
                            {foreach $logs as $log}
                                <tr>
                                    <td>#{$log->id}</td>
                                    <td>{$log->user_id}</td>
                                    <td>{$log->user()->user_name}</td>
                                    <td>{$log->traffic()}</td>
                                    <td>{$log->CheckInTime()}</td>
                                </tr>
                            {/foreach}
                        </table>
                        {$logs->render()}
                    </div><!-- /.box-body -->
                </div><!-- /.box -->
            </div>
        </div>

    </section><!-- /.content -->
</div><!-- /.content-wrapper -->
<script>
    $("#cleanlog").click(function () {
        $.ajax({
            type: "POST",
            url: "/admin/checkinlog/clear",
            dataType: "json",
            success: function (data) {
                if (data.ret) {
                    $("#msg-success").show(100);
                    $("#msg-success-p").html(data.msg);
                    window.setTimeout("location.href='/admin/checkinlog'", 1000);
                }
                // window.location.reload();
            },
            error: function (jqXHR) {
                alert("发生错误：" + jqXHR.status);
            }
        })
    });
</script>
{include file='admin/footer.tpl'}
