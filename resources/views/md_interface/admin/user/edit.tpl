{include file='admin/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            用户编辑
            <small>Edit User</small>
            <br><h4>用户名:{$user->user_name}&nbsp;用户ID:{$user->id} </h4>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div id="msg-success" class="alert alert-success alert-dismissable" style="display: none;">
                    <button type="button" class="close" id="ok-close" aria-hidden="true">&times;</button>
                    <h4><i class="icon fa fa-info"></i> 成功!</h4>

                    <p id="msg-success-p"></p>
                </div>
                <div id="msg-error" class="alert alert-warning alert-dismissable" style="display: none;">
                    <button type="button" class="close" id="error-close" aria-hidden="true">&times;</button>
                    <h4><i class="icon fa fa-warning"></i> 出错了!</h4>

                    <p id="msg-error-p"></p>
                </div>
            </div>
        </div>
        <div class="row">
            <!-- left column -->
            <div class="col-md-12">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-body">
                        <div class="form-horizontal">
                            <div class="row">
                                <fieldset class="col-sm-6">
                                    <legend>帐号信息</legend>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">邮箱</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="email" type="email" value="{$user->email}">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">密码</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="pass" value="" placeholder="不修改时留空">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">是否管理员</label>

                                        <div class="col-sm-9">
                                            <select class="form-control" id="is_admin">
                                                <option value="0" {if $user->is_admin==0}selected="selected"{/if}>
                                                    否
                                                </option>
                                                <option value="1" {if $user->is_admin==1}selected="selected"{/if}>
                                                    是
                                                </option>
                                            </select>
                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">用户状态</label>

                                        <div class="col-sm-9"><select class="form-control" id="enable">
                                                <option value="1" {if $user->enable==1}selected="selected"{/if}>
                                                    正常
                                                </option>
                                                <option value="0" {if $user->enable==0}selected="selected"{/if}>
                                                    禁用
                                                </option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">用户级别</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="user_level" value="{$user->level}">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">用户群组</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="user_group" value="{$user->g}">
                                        </div>
                                    </div>

                                </fieldset>
                                <fieldset class="col-sm-6">
                                    <legend>ShadowSocks连接信息</legend>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">连接端口</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="port" type="number" value="{$user->port}">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">连接密码</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="passwd" value="{$user->passwd}">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">自定义加密</label>

                                        <div class="col-sm-9">
                                            <select class="form-control" id="method">
                                                <option value="{$user->method}"> 当前:{$user->method}</option>
                                                <option value="aes-128-cfb">aes-128-cfb</option>
                                                <option value="aes-192-cfb">aes-192-cfb</option>
                                                <option value="aes-256-cfb">aes-256-cfb</option>
                                                <option value="aes-128-ctr">aes-128-ctr</option>
                                                <option value="aes-192-ctr">aes-192-ctr</option>
                                                <option value="aes-256-ctr">aes-256-ctr</option>
                                                <option value="bf-cfb">bf-cfb</option>
                                                <option value="camellia-128-cfb">camellia-128-cfb</option>
                                                <option value="camellia-192-cfb">camellia-192-cfb</option>
                                                <option value="camellia-256-cfb">camellia-256-cfb</option>
                                                <option value="rc4-md5">rc4-md5</option>
                                                <option value="rc4-md5-6">rc4-md5-6</option>
                                                <option value="salsa20">salsa20</option>
                                                <option value="xsalsa20">xsalsa20</option>
                                                <option value="chacha20">chacha20</option>
                                                <option value="xchacha20">xchacha20</option>
                                                <option value="chacha20-ietf">chacha20-ietf</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">SSR协议</label>

                                        <div class="col-sm-9">
                                            <select class="form-control" id="SSRProtocol">
                                                <option value="{$user->protocol}">当前:{$user->protocol}</option>
                                                <option value="origin">origin(无协议)</option>
                                                <option value="auth_sha1_v4">auth_sha1_v4</option>
                                                <option value="auth_aes128_md5">auth_aes128_md5</option>
                                                <option value="auth_aes128_sha1">auth_aes128_sha1</option>
                                                <option value="auth_chain_a">auth_chain_a</option>
                                                <option value="auth_chain_b">auth_chain_b</option>
                                                <option value="auth_chain_c">auth_chain_c</option>
                                                <option value="auth_chain_d">auth_chain_d</option>
                                                <option value="auth_chain_e">auth_chain_e</option>
                                                <option value="auth_chain_f">auth_chain_f</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">SSR混淆</label>

                                        <div class="col-sm-9">
                                            <select class="form-control" id="SSRobfs">
                                                <option value="{$user->obfs}">当前:{$user->obfs}</option>
                                                <option value="plain">plain(无混淆)</option>
                                                <option value="http_simple">http_simple</option>
                                                <option value="tls1.2_ticket_auth">tls1.2_ticket_auth</option>
                                                <option value="tls1.2_ticket_fastauth">tls1.2_ticket_fastauth</option>
                                            </select>
                                        </div>
                                    </div>
                                </fieldset>
                            </div>
                            <div class="row">
                                <fieldset class="col-sm-6">
                                    <legend>流量</legend>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">总流量</label>

                                        <div class="col-sm-9">
                                            <div class="input-group">
                                                <input class="form-control" id="transfer_enable" type="number"
                                                       value="{$user->enableTrafficInGB()}">
                                                <div class="input-group-addon">GiB</div>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">已用流量</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="traffic_usage" type="text"
                                                   value="{$user->usedTraffic()}" readonly>
                                        </div>
                                    </div>
                                </fieldset>
                                <fieldset class="col-sm-6">
                                    <legend>邀请</legend>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">可用邀请数量</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="invite_num" type="number"
                                                   value="{$user->invite_num}">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">邀请人ID</label>

                                        <div class="col-sm-9">
                                            <input class="form-control" id="ref_by" type="number"
                                                   value="{$user->ref_by}" readonly>
                                        </div>
                                    </div>
                                </fieldset>
                            </div>
                        </div>
                    </div>
                    <!-- /.box-body -->
                    <div class="box-footer">
                        <button type="submit" id="submit" name="action" value="add" class="btn btn-primary">修改</button>
                    </div>
                </div>
            </div>
            <!-- /.box -->
        </div>
        <!-- /.row -->
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->

<script>
    $(document).ready(function () {
        function submit() {
            $.ajax({
                type: "PUT",
                url: "/admin/user/{$user->id}",
                dataType: "json",
                data: {
                    email: $("#email").val(),
                    pass: $("#pass").val(),
                    port: $("#port").val(),
                    passwd: $("#passwd").val(),
                    transfer_enable: $("#transfer_enable").val(),
                    invite_num: $("#invite_num").val(),
                    method: $("#method").val(),
                    enable: $("#enable").val(),
                    is_admin: $("#is_admin").val(),
                    ref_by: $("#ref_by").val(),
                    SSRobfs: $("#SSRobfs").val(),
                    SSRProtocol: $("#SSRProtocol").val(),
                    user_level: $("#user_level").val(),
                    user_group: $("#user_group").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-error").hide(100);
                        $("#msg-success").show(100);
                        $("#msg-success-p").html(data.msg);
                        window.setTimeout("location.href='/admin/user'", 2000);
                    } else {
                        $("#msg-error").hide(10);
                        $("#msg-error").show(100);
                        $("#msg-error-p").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#msg-error").hide(10);
                    $("#msg-error").show(100);
                    $("#msg-error-p").html("发生错误：" + jqXHR.status);
                }
            });
        }

        $("html").keydown(function (event) {
            if (event.keyCode == 13) {
                login();
            }
        });
        $("#submit").click(function () {
            submit();
        });
        $("#ok-close").click(function () {
            $("#msg-success").hide(100);
        });
        $("#error-close").click(function () {
            $("#msg-error").hide(100);
        });
    })
</script>


{include file='admin/footer.tpl'}
