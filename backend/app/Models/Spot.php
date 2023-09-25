<?php

namespace App\Models;

use App\Models\Venue;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Spot extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $fillable = [
        'id_venue',
        'total_spot',
        'spot_name',
        'kapasitas',
        'indoor_outdoor',
        'kursi',
        'r_meeting',
        'genset',
        'sound_system',
        'r_makeup',
        'm_panggung',
        'r_transit',
        'listrik',
        'other_fac',
        'halfday',
        'fullday',
        'other_harga',
    ];

    // Define a relationship to the Venue model
    public function venue()
    {
        return $this->belongsTo(Venue::class, 'id_venue', 'id');
    }
}

