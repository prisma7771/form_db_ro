<?php

namespace App\Http\Controllers\api;

use App\Models\Spot;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\DataResource;
use Illuminate\Support\Facades\Validator;

class SpotController extends Controller
{
    public function store(Request $request)
    {
        //define validation rules
        $validator = Validator::make($request->all(), [
            'id_venue' => 'required',
            'spot_name' => 'required',
        ]);

        // Create a new Spot record
        $spot = new Spot();
        $spot->fill($request->all()); // Assuming 'venue_id' is the foreign key linking Venue and Spot
        $spot->save();

        //return response
        return new DataResource(true, 'Data Post Berhasil Ditambahkan!', $spot);
    }

    public function destroy($id)
    {
        // Find the Venue by ID
        $spot = Spot::where('spot_id', $id)->first();

        // Check if the venue exists
        if (!$spot) {
            return new DataResource(false, 'Spot not found.', $spot);
        }

        // Delete the associated spots first
        $spot = Spot::where('spot_id', $id)->delete();

        // Return a response indicating success
        return new DataResource(true, 'Spot removed successfully.', $spot);
    }

    public function show($id)
    {
        // Find post by ID
        $spot = Spot::where('spot_id', $id)->first();

        // Return single post as a resource
        return new DataResource(true, 'Detail Data Item!', $spot);
    }

    public function update(Request $request, $id)
    {
         // Validate the request data if needed
         $request->validate([
            'spot.spot_name' => 'required|string',
            // Add validation rules for other venue fields as needed
        ]);

        // Update Spot by ID
        $spot = Spot::where('spot_id', $id)->update($request->input('spot'));

        // Return a response indicating success
        return new DataResource(true, 'Update Data Spot!', $spot);
    }
}
