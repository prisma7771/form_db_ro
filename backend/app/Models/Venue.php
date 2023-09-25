<?php

namespace App\Models;

use App\Models\Image;
use App\Models\Spot;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Venue extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $fillable = [
        'nama_venue',
        'cp_marketing',
        'no_cp',
        'address',
        'area',
        'harga_pack',
        'lain_lain',
        'charge'
    ];

    // Define a relationship to the Spot model if needed
    public function spots()
    {
        return $this->hasMany(Spot::class, 'id_venue', 'id');
    }

    public function images()
    {
        return $this->hasMany(Image::class, 'id_venue', 'id');
    }
}
