{include file='admin/main.tpl'}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            付款记录
            <small>User Payment</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <div class="box">
                    <div class="box-body table-responsive no-padding">
                        <div class="row">
                            <div class="col-xs-6">
                                {$users->appends(['email' => $email])->render()}
                            </div>
                            <div class="col-xs-6 form-inline pagination">
                                <div class="form-group">
                                    <label for="email" class="control-label">用户email</label>
                                    <input class="form-control" id="email" placeholder="请输入邮箱" value="{$email}">
                                </div>
                                <button class="btn btn-info" id="query">查询</button>
                                <button class="btn btn-danger" id="clean">清空所有记录</button>
                            </div>
                        </div>
                        <table class="table table-hover">
                            <tr>
                                <td><input type="checkbox" class="userListAll" id="userListAll"></td>
                                <th>ID</th>
                                <th>用户名</th>
                                <th>邮箱</th>
                                <th>端口</th>
                                <th>状态</th>
                                <th>最后在线时间</th>
                                <th>最后付款时间</th>
                                <th>下月是否已付</th>
                                <th>操作</th>
                            </tr>
                            {foreach $users as $user}
                                <tr>
                                    <td><input type="checkbox" class="userList" id="{$user->id}" value="{$user->id}-{$user->user_name}" onclick="doList()"></td>
                                    <td>{$user->id}</td>
                                    <td>{$user->user_name}</td>
                                    <td>{$user->email}</td>
                                    <td>{$user->port}</td>
                                    <td>{$user->enableText()}</td>
                                    <th>{$user->lastSsTime()}</th>
                                    <th>{$user->payment()}</th>
                                    <th>{$user->lastpayment()}</th>
                                    <td>
                                        <a class="btn btn-info btn-sm" href="/admin/payment/{$user->id}/edit">编辑</a>
                                        <a class="btn btn-danger btn-sm" id="delete" value="{$user->id}"
                                           href="/admin/user/{$user->id}/delete">删除用户</a>
                                    </td>
                                </tr>
                            {/foreach}
                        </table>
                    </div><!-- /.box-body -->
                </div><!-- /.box -->
                <div class="row">
                    <div class="col-xs-6" id="selectIds">

                    </div>
                    <div class="col-xs-6">
                        <button class="btn btn-info" id="edits">提交</button>
                    </div>
                </div>
            </div>
        </div>

    </section><!-- /.content -->
</div><!-- /.content-wrapper -->


<script>
    function doList(){
        $("#selectIds").empty();
        var htmlText = "<p>已经选中:<br><ul class=\"list-unstyled\">";
        var ids = "<li>ID:";
        var names = "<li>用户名:";
        $(".userList").each(function () {
            if($(this).is(":checked")==true){
                var val = $(this).val().split("-");
                ids += ("<span>&nbsp;" + val[0] + "&nbsp;</span>");
                names += ("<span>&nbsp;" + val[1] + "&nbsp;</span>");
            }
        });
        ids += "</li>";
        names += "</li>";
        htmlText += ids + names + "</p>";
        $("#selectIds").append(htmlText);
    }
    $(document).ready(function () {
        $("#query").click(function () {
            window.location.href = '/admin/payment?email=' + $("#email").val();
        });
        $("html").keydown(function (event) {
            if (event.keyCode == 13) {
                login();
            }
        });
        $("#userListAll").click(function () {
            var isCheck = $(this).is(":checked");
            $(".userList").each(function () {
                $(this).prop("checked", isCheck);
            });
            doList();
        });
        $(".pagination").addClass("pagination-sm");
    });

</script>

{include file='admin/footer.tpl'}