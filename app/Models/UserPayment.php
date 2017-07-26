<?php


namespace App\Models;

use App\Utils\Tools;


class UserPayment extends Model
{
    protected $table = "user_payment";

    public function user()
    {
        return User::find($this->attributes['user_id']);
    }

    public function payDate()
    {
        return Tools::toDateTime($this->attributes['payment_date']);
    }
}