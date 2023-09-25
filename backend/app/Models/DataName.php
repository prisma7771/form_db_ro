<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Casts\Attribute;

class DataName extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $fillable = [
        'title',
        'description',
        'Class',
        'Color'
    ];

    protected function image(): Attribute
    {
        return Attribute::make(
            get: fn ($image) => asset('/storage/posts/' . $image),
        );
    }
}
