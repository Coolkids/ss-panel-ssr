{include file='admin/main.tpl'}
<script src="/assets/public/js/echarts.min.js"></script>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            用户列表
            <small>User List</small>
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
                            </div>
                        </div>
                        <table class="table table-hover">
                            <tr>
                                <th>ID</th>
                                <th>群组</th>
                                <th>级别</th>
                                <th>用户名</th>
                                <th>邮箱</th>
                                <th>端口</th>
                                <th>状态</th>
                                <th>加密方式</th>
                                <th>协议</th>
                                <th>混淆</th>
                                <th>上传/下载</th>
                                <th>已用流量/总流量</th>
                                <th>用户名</th>
                                <th>最后在线时间</th>
                                {*<th>最后签到时间</th>*}
                                <th>注册时间</th>
                                <th>注册IP</th>
                                <th>邀请者</th>
                                <th>操作</th>
                            </tr>
                            {foreach $users as $user}
                                <tr>
                                    <td>{$user->id}</td>
                                    <td>{$user->g}</td>
                                    <td>{$user->level}</td>
                                    <td>{$user->user_name}</td>
                                    <td>{$user->email}</td>
                                    <td>{$user->port}</td>
                                    <td>{$user->enable}</td>
                                    <td>{$user->method}</td>
                                    <td>{$user->protocol}</td>
                                    <td>{$user->obfs}</td>
                                    <td>{$user->usedUpTraffic()}/{$user->usedDownTraffic()}</td>
                                    <td>{$user->usedTraffic()}/{$user->enableTraffic()}</td>
                                    <td>{$user->user_name}</td>
                                    <td>{$user->lastSsTime()}</td>
                                    {*<td>{$user->lastCheckInTime()}</td>*}
                                    <th>{$user->reg_date}</th>
                                    <th>{$user->reg_ip}</th>
                                    <th>{$user->ref_byUser()->user_name}</th>
                                    <td>
                                        <a class="btn btn-info btn-sm" href="/admin/user/{$user->id}/edit">编辑</a>
                                        <a class="btn btn-danger btn-sm" id="delete" value="{$user->id}"
                                           href="/admin/user/{$user->id}/delete">删除</a>
                                    </td>
                                </tr>
                            {/foreach}
                        </table>
                        <div class="row">
                            <!-- on column -->
                            <div class="col-md-6">
                                <div id="bar_chart" style="width: 100%;height: 500px;margin: auto"></div>
                                <script>
                                    $(document).ready(function () {
                                        var xa = [];
                                        var ya = [];
                                        var data = {$echartData};
                                        for (var o in data) {
                                            xa.push(data[o].name);
                                            ya.push(data[o].value);
                                        }

                                        var myChart = echarts.init(document.getElementById('bar_chart'));
                                        myChart.setOption({
                                            tooltip : {
                                                trigger: 'axis',
                                                axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                                                    type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                                                }
                                            },
                                            grid: {
                                                left: '3%',
                                                right: '4%',
                                                bottom: '3%',
                                                containLabel: true
                                            },
                                            xAxis: {
                                                type: 'category',
                                                axisTick: {
                                                    alignWithLabel: true
                                                },
                                                data: xa
                                            },
                                            yAxis: {
                                                type: 'value'
                                            },
                                            dataZoom: [
                                                {
                                                    type: 'inside'
                                                }
                                            ],
                                            series: [{
                                                name: '流量',
                                                type: 'bar',
                                                barWidth: '60%',
                                                data: ya
                                            }]
                                        });

                                        var zoomSize = 6;
                                        myChart.on('click', function (params) {
                                            //console.log(dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)]);
                                            myChart.dispatchAction({
                                                type: 'dataZoom',
                                                startValue: xa[Math.max(params.dataIndex - zoomSize / 2, 0)],
                                                endValue: xa[Math.min(params.dataIndex + zoomSize / 2, data.length - 1)]
                                            });
                                        });
                                    });
                                </script>
                            </div>
                            <div class="col-md-6">
                                <div id="per_chart" style="width: 100%;height: 500px;margin: auto"></div>
                                <script>
                                    $(document).ready(function () {
                                        var xa = [];
                                        var data = {$echartData};
                                        for (var o in data) {
                                            xa.push(data[o].name);
                                        }
                                        var myChart = echarts.init(document.getElementById('per_chart'));
                                        myChart.setOption({
                                            tooltip: {
                                                trigger: 'item',
                                                formatter: {"{a} <br/>{b}: {c} ({d}%)"}
                                            }
                                            legend: {
                                                orient: 'vertical',
                                                x: 'left',
                                                data:xa
                                            },
                                            series: [
                                                {
                                                    name:'使用情况',
                                                    type:'pie',
                                                    radius: ['50%', '70%'],
                                                    avoidLabelOverlap: false,
                                                    label: {
                                                        normal: {
                                                            show: false,
                                                            position: 'center'
                                                        },
                                                        emphasis: {
                                                            show: true,
                                                            textStyle: {
                                                                fontSize: '30',
                                                                fontWeight: 'bold'
                                                            }
                                                        }
                                                    },
                                                    labelLine: {
                                                        normal: {
                                                            show: false
                                                        }
                                                    },
                                                    data:data
                                                }
                                            ]
                                        });
                                    });
                                </script>
                            </div>
                        </div>
                    </div><!-- /.box-body -->
                </div><!-- /.box -->
            </div>
        </div>

    </section><!-- /.content -->
</div><!-- /.content-wrapper -->


<script>
    $(document).ready(function () {
        function delete2() {
            $.ajax({
                type: "DELETE",
                url: "/admin/user/",
                dataType: "json",
                data: {
                    name: $("#name").val()
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
        $("#delete").click(function () {
            delete2();
        });
        $("#ok-close").click(function () {
            $("#msg-success").hide(100);
        });
        $("#error-close").click(function () {
            $("#msg-error").hide(100);
        });
        $("#query").click(function () {
            window.location.href = '/admin/user?email=' + $("#email").val();
        });
        $(".pagination").addClass("pagination-sm");
    });
</script>

{include file='admin/footer.tpl'}