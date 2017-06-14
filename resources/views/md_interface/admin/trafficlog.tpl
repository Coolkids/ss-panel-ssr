{include file='admin/main.tpl'}
<script src="/assets/public/js/echarts.min.js"></script>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            流量使用记录
            <small>Traffic Log</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <!--div class="row">
            <div class="col-md-12">
                <div class="callout callout-warning">
                    <h4>注意!</h4>
                    <p>部分节点不支持流量记录.</p>
                </div>
            </div>
        </div-->
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
                        <div class="form-inline" style="margin-top: 5px;">
                            <div class="form-group">
                                <label for="userId" class="control-label">用户ID</label>
                                <select class="form-control" id="userId">
                                    <option value="">全部</option>
                                    {foreach $users as $user}
                                        <option value="{$user->id}">{$user->user_name}:{$user->email}</option>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="nodeId" class="control-label">节点</label>
                                <select class="form-control" id="nodeId">
                                    <option value="">全部</option>
                                    {foreach $nodes as $node}
                                        <option value="{$node->id}">{$node->name}</option>
                                    {/foreach}
                                </select>
                            </div>
                            <button class="btn btn-info" id="query" >查询</button>
                            <button class="btn btn-danger" id="cleanuser">重置</button>
                            <button class="btn btn-danger" id="cleanlog" style="float: right;">清空记录</button>
                        </div>
                    </div>
                    {$logs->appends(['userId' => $userId, 'nodeId' => $nodeId])->render()}
                    <table class="table table-hover">
                        <tr>
                            <th>ID</th>
                            <th>用户</th>
                            <th>用户名</th>
                            <th>节点ID</th>
                            <th>使用节点</th>
                            <th>倍率</th>
                            <th>实际使用流量</th>
                            <th>结算流量</th>
                            <th>记录时间</th>
                        </tr>
                        {foreach $logs as $log}
                            <tr>
                                <td>#{$log->id}</td>
                                <td>{$log->user_id}</td>
                                <td>{$log->user()->user_name}</td>
                                <td>{$log->node_id}</td>
                                <td>{$log->node()->name}</td>
                                <td>{$log->rate}</td>
                                <td>{$log->totalUsed()}</td>
                                <td>{$log->traffic}</td>
                                <td>{$log->logTime()}</td>
                            </tr>
                        {/foreach}
                    </table>
                    <div id="day_chart" style="width: 100%;height: 500px;margin: auto"></div>
                    <script>
                        $(document).ready(function () {
                            var xa = [];
                            var ya = [];
                            var data = {$echartDay};
                            for (var o in data) {
                                xa.push(data[o].log_time);
                                ya.push(data[o].total);
                            }

                            var myChart = echarts.init(document.getElementById('day_chart'));
                            myChart.setOption({
                                title: {
                                    text: '{$node_t}的{$user_t}日流量数据'
                                },
                                tooltip: {
                                    trigger: 'axis',
                                    axisPointer: {
                                        animation: false
                                    },
                                    {literal}
                                    formatter: "{b}<br/>{a}:{c}MB"
                                    {/literal}
                                },
                                xAxis: {
                                    type: 'category',
                                    splitLine: {
                                        show: false
                                    },
                                    data: xa
                                },
                                yAxis: {
                                    type: 'value',
                                    splitLine: {
                                        show: false
                                    }
                                },
                                dataZoom: [
                                    {
                                        type: 'inside'
                                    }
                                ],
                                series: [{
                                    name: '流量',
                                    type: 'line',
                                    smooth: true,
                                    data: ya
                                }]
                            });

                            var zoomSize = 60;
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
                    <div id="hour_chart" style="width: 100%;height: 500px;margin: auto"></div>
                    <script>
                        $(document).ready(function () {
                            var xa = [];
                            var ya = [];
                            var data = {$echartHour};
                            for (var o in data) {
                                xa.push(data[o].log_time);
                                ya.push(data[o].total);
                            }

                            var myChart = echarts.init(document.getElementById('hour_chart'));
                            myChart.setOption({
                                title: {
                                    text: '{$node_t}的{$user_t}小时流量数据'
                                },
                                tooltip: {
                                    trigger: 'axis',
                                    axisPointer: {
                                        animation: false
                                    },
                                    {literal}
                                    formatter: "{b}<br/>{a}:{c}MB"
                                    {/literal}
                                },
                                xAxis: {
                                    type: 'category',
                                    splitLine: {
                                        show: false
                                    },
                                    data: xa
                                },
                                yAxis: {
                                    type: 'value',
                                    splitLine: {
                                        show: false
                                    }
                                },
                                dataZoom: [
                                    {
                                        type: 'inside'
                                    }
                                ],
                                series: [{
                                    name: '流量',
                                    type: 'line',
                                    smooth: true,
                                    data: ya
                                }]
                            });

                            var zoomSize = 60;
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
                    <div id="total_chart" style="width: 100%;height: 500px;margin: auto"></div>
                    <script>
                        $(document).ready(function () {
                            var xa = [];
                            var ya = [];
                            var data = {$echartData};
                            for (var o in data) {
                                xa.push(new Date(data[o].log_time*1000).toLocaleString());
                                ya.push(data[o].total);
                            }

                            var myChart = echarts.init(document.getElementById('total_chart'));
                            myChart.setOption({
                                title: {
                                    text: '{$node_t}的{$user_t}全部流量数据'
                                },
                                tooltip: {
                                    trigger: 'axis',
                                    axisPointer: {
                                        animation: false
                                    },
                                    {literal}
                                    formatter: "{b}<br/>{a}:{c}MB"
                                    {/literal}
                                },
                                xAxis: {
                                    type: 'category',
                                    splitLine: {
                                        show: false
                                    },
                                    data: xa
                                },
                                yAxis: {
                                    type: 'value',
                                    splitLine: {
                                        show: false
                                    }
                                },
                                dataZoom: [
                                    {
                                        type: 'inside'
                                    }
                                ],
                                series: [{
                                    name: '流量',
                                    type: 'line',
                                    smooth: true,
                                    data: ya
                                }]
                            });

                            var zoomSize = 60;
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
                </div><!-- /.box-body -->
            </div><!-- /.box -->
        </div>
</div>

</section><!-- /.content -->
</div><!-- /.content-wrapper -->
<script>
    $(document).ready(function () {
        $("#userId").val({$userId});
        $("#nodeId").val({$nodeId});
        $("#query").click(function () {
            window.location.href = '/admin/trafficlog?userId=' + $("#userId").val() + '&nodeId=' + $("#nodeId").val();
        });
        $("#cleanuser").click(function () {
            var r=confirm("确认清空用户流量么?");
            if(r!=true){
                return;
            }
            $.ajax({
                type: "POST",
                url: "/admin/api/cleanuser",
                dataType: "json",
                data: {
                    userId: $("#userId").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-success").show(100);
                        $("#msg-success-p").html(data.msg);
                        window.setTimeout("location.href='/admin/trafficlog'", 1000);
                    }
                    // window.location.reload();
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        });
        //不建议清空流量日志
        $("#cleanlog").click(function () {
            var r=confirm("确认清空流量日志么?此操作会影响节点流量统计");
            if(r!=true){
                return;
            }
            $.ajax({
                type: "POST",
                url: "/admin/api/cleanlog",
                dataType: "json",
                data: {
                    nodeId: $("#nodeId").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#msg-success").show(100);
                        $("#msg-success-p").html(data.msg);
                        window.setTimeout("location.href='/admin/trafficlog'", 1000);
                    }
                    // window.location.reload();
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        });
        //$(".pagination").addClass("pagination-sm");
    })
</script>
{include file='admin/footer.tpl'}
