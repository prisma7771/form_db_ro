<?php

namespace App\Models;

use App\Models\Venue;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Casts\Attribute;

class Image extends Model
{

    public $timestamps = false;

    protected $fillable = [
        'id_venue',
        'image',
        'spot_id'
    ];

    public function venue()
    {
        return $this->belongsTo(Venue::class, 'id_venue', 'id');
    }

    protected function image(): Attribute
    {
        return Attribute::make(
            get: fn ($image) => url('/storage/img/' . $image),
        );
    }
    
}
