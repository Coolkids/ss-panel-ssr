<?php

namespace App\Controllers\Admin;

use App\Controllers\AdminController;
use App\Models\TrafficLog;
use App\Models\User;
use App\Models\UserPayment;
use App\Utils\Hash;
use App\Utils\Tools;

class UserController extends AdminController
{
    public function index($request, $response, $args)
    {
        $pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
        $email = null;
        if (isset($request->getQueryParams()["email"])) {
            $email = $request->getQueryParams()["email"];
            if($email==""){
                $email = null;
            }
        }
        $users = null;
        if($email != null){
            $users = User::where('email', 'like', '%' . $email . '%')->paginate(30, ['*'], 'page', $pageNum);
        }else{
            $users = User::paginate(30, ['*'], 'page', $pageNum);
        }

        $echartData = User::hydrateRaw("select user_name as `name`, ROUND((u+d)/(1024*1024), 2) as `value` from `user`");

        $users->setPath('/admin/user');
        return $this->view()
            ->assign('users', $users)
            ->assign('email', $email)
            ->assign('echartData', $echartData)
            ->display('admin/user/index.tpl');
    }

    public function edit($request, $response, $args)
    {
        $id = $args['id'];
        $user = User::find($id);
        if ($user == null) {

        }
        return $this->view()->assign('user', $user)->display('admin/user/edit.tpl');
    }

    public function update($request, $response, $args)
    {
        $id = $args['id'];
        $user = User::find($id);

        $user->email = $request->getParam('email');
        if ($request->getParam('pass') != '') {
            $user->pass = Hash::passwordHash($request->getParam('pass'));
        }
        if ($request->getParam('passwd') != '') {
            $user->passwd = $request->getParam('passwd');
        }
        $user->port = $request->getParam('port');
        $user->transfer_enable = Tools::toGB($request->getParam('transfer_enable'));
        $user->invite_num = $request->getParam('invite_num');
        $user->method = $request->getParam('method');
        $user->enable = $request->getParam('enable');
        $user->is_admin = $request->getParam('is_admin');
        $user->ref_by = $request->getParam('ref_by');
        $user->protocol = $request->getParam('SSRProtocol');
        $user->obfs = $request->getParam('SSRobfs');
        $user->level = $request->getParam('user_level');
        $user->g = $request->getParam('user_group');
        if (!$user->save()) {
            $rs['ret'] = 0;
            $rs['msg'] = "修改失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "修改成功";
        return $response->getBody()->write(json_encode($rs));
    }

    public function delete($request, $response, $args)
    {
        $id = $args['id'];
        $user = User::find($id);
        if (!$user->delete()) {
            $rs['ret'] = 0;
            $rs['msg'] = "删除失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "删除成功";
        return $response->getBody()->write(json_encode($rs));
    }

    public function deleteGet($request, $response, $args)
    {
        $id = $args['id'];
        $user = User::find($id);
        $user->delete();
        $newResponse = $response->withStatus(302)->withHeader('Location', '/admin/user');
        return $newResponse;
    }

    public function cleanuser($request, $response, $args)
    {
        $userId = $request->getParam('userId');
        try {
            if ($userId == "") {
                User::where("enable", 1)->update([
                    'd' => 0,
                    'u' => 0,
                ]);
            } else {
                User::where("enable", 1)->where("id", "=", $userId)->update([
                    'd' => 0,
                    'u' => 0,
                ]);
                //不清除 否则会影响统计
                //TrafficLog::where("user_id", "=", $userId)->delete();
            }
            $rs['ret'] = 1;
            $rs['msg'] = "清空用户流量完成";
            return $response->getBody()->write(json_encode($rs));
        } catch (\Exception $e) {
            echo $e->getMessage();
            $rs['ret'] = 0;
            $rs['msg'] = "清空用户流量失败";
            return $response->getBody()->write(json_encode($rs));
        }
    }

    public function paymentIndex($request, $response, $args){
        $pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
        $email = "";
        if (isset($request->getQueryParams()["email"])) {
            $email = $request->getQueryParams()["email"];
        }
        $type = "-1";
        if (isset($request->getQueryParams()["type"])) {
            $type = $request->getQueryParams()["type"];
        }

        $pageIndex = ($pageNum-1)*30;
        $sql = "SELECT a.* FROM `user` as a LEFT JOIN `user_payment` as b on a.id=b.id where a.email like '%?%' ";
        if($type == "-1"){

        }elseif ($type == "0"){
            $sql = $sql . " and (month(b.payment_date)<>month(now()) or b.payment_date is null)";
        }elseif($type == "1"){
            $sql = $sql . " and month(b.payment_date)=month(now()) ";
        }
        $sql = $sql . "limit ". $pageIndex .",30";

        $users = User::hydrateRaw($sql, [$email]);

        $type->setPath('/admin/payment');
        return $this->view()
            ->assign('users', $users)
            ->assign('email', $email)
            ->assign('type', $type)
            ->display('admin/payment/index.tpl');
    }

    public function paymentEdit($request, $response, $args)
    {
        $id = $args['id'];
        $user = User::find($id);
        if ($user == null) {

        }
        return $this->view()->assign('user', $user)->display('admin/payment/edit.tpl');
    }

    public function paymentUpdate($request, $response, $args)
    {
        $id = $args['id'];
        $date = $request->getParam('paymentDate');

        $userpayment = UserPayment::find($id);
        if($userpayment==null){
            $userpayment = new UserPayment();
            $userpayment->id=$id;
        }
        $userpayment->payment_date = $date;

        if (!$userpayment->save()) {
            $rs['ret'] = 0;
            $rs['msg'] = "修改失败";
            return $response->getBody()->write(json_encode($rs));
        }

        $rs['ret'] = 1;
        $rs['msg'] = "修改成功";
        return $response->getBody()->write(json_encode($rs));
    }

    public function paymentUpdateGET($request, $response, $args)
    {
        $id = $args['id'];
        $date = date('Y-m-d', time()) ;

        $userpayment = UserPayment::find($id);
        if($userpayment==null){
            $userpayment = new UserPayment();
            $userpayment->id=$id;
        }
        $userpayment->payment_date = $date;

        $userpayment->save();

        return $this->paymentIndex($request, $response, $args);
    }

    public function paymentClean($request, $response, $args)
    {
        $date = $request->getParam('message');

        if($date!="CWlhcovnYTJmlQt2kA74"){
            $rs['ret'] = 0;
            $rs['msg'] = "修改失败";
            return $response->getBody()->write(json_encode($rs));
        }

        UserPayment::where("id", ">", -99)->delete();

        $rs['ret'] = 1;
        $rs['msg'] = "修改成功";
        return $response->getBody()->write(json_encode($rs));
    }

    public function paymentUsers($request, $response, $args)
    {
        $ids = $request->getParam('ids');
        $date = date('Y-m-d', time()) ;

        foreach ($ids as $id)
        {
            $userpayment = UserPayment::find($id);
            if($userpayment==null){
                $userpayment = new UserPayment();
                $userpayment->id=$id;
            }
            $userpayment->payment_date = $date;

            $userpayment->save();
        }

        $rs['ret'] = 1;
        $rs['msg'] = "修改成功";
        return $response->getBody()->write(json_encode($rs));
    }

}