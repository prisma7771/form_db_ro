<?php

namespace App\Http\Controllers\api;

use App\Models\Spot;
use App\Models\Image;
use App\Models\Venue;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\DataResource;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class DataController extends Controller
{
    public function index()
    {
        // Retrieve a list of spots with their related venues
        $venue = Venue::with('spots')->get();

        // Pass the data to a view and render it
        return new DataResource(true, 'List Data Posts', $venue);
    }

    public function show($id)
    {
        // Find post by ID
        $venue = Venue::with('spots')->find($id);

        // Return single post as a resource
        return new DataResource(true, 'Detail Data Item!', $venue);
    }

    public function store(Request $request)
    {
        // Validate the request data if needed
        $request->validate([
            'venue.nama_venue' => 'required|string',
            // Add validation rules for other venue fields as needed
            'spot.spot_name' => 'required|string',
            // Add validation rules for other spot fields as needed
        ]);

        // Create a new Venue record
        $venue = new Venue();
        $venue->fill($request->input('venue'));
        $venue->save();

        // Create a new Spot record
        $spot = new Spot();
        $spot->fill($request->input('spot'));
        $spot->id_venue = $venue->id; // Assuming 'venue_id' is the foreign key linking Venue and Spot
        $spot->save();

        // Return a response indicating success
        return new DataResource(true, 'Upload Data Item!', $request->all());
    }

    public function update(Request $request, $id)
    {
        // Find the venue record by ID
        $venue = Venue::findOrFail($id);

        // Validate the request data if needed
        $request->validate([
            'venue.nama_venue' => 'required|string',
            // Add validation rules for other venue fields as needed
        ]);

        // Update the Venue attributes with the new data
        $venue->update($request->input('venue'));

        // Return a response indicating success
        return new DataResource(true, 'Upload Data Item!', $venue);
    }

    public function destroy($id)
    {
        // Find the Venue by ID
        $venue = Venue::find($id);

        // Check if the venue exists
        if (!$venue) {
            return new DataResource(false, 'Venue not found.');
        }

        // Get all images associated with venue id 1
        $images = Image::where('id_venue', $id)->get();

        // Loop through the images and delete each one
        foreach ($images as $image) {
            // Delete the image file
            Storage::delete('public/posts/' . basename($image->image));

            // Update the associated Spot records where id_venue matches $id
            $image = Image::where('id_venue', $id)->delete();
        }

        // Delete the associated spots first
        $venue->spots()->delete();

        // Then delete the venue
        $venue->delete();

        // Return a response indicating success
        return new DataResource(true, 'Venue and associated images removed successfully.', $id);
    }
}
