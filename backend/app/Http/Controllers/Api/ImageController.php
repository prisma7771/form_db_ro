<?php

namespace App\Http\Controllers\api;

use App\Models\Image;
use App\Models\Venue;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\DataResource;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class ImageController extends Controller
{

    public function store(Request $request)
    {
        //define validation rules
        $validator = Validator::make($request->all(), [
            'id_venue' => 'required',
            'image'     => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);

        //check if validation fails
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        //upload image
        $image = $request->file('image');
        $image->storeAs('public/posts', $request->id_venue . '_' . $image->hashName());

        //create post
        $image = Image::create([
            'id_venue' => $request->id_venue,
            'image'     => $request->id_venue . '_' . $image->hashName(),
        ]);

        //return response
        return new DataResource(true, 'Data Post Berhasil Ditambahkan!', $image);
    }

    public function show($id)
    {
        // Find post by ID
        $venue = Venue::with('images')->find($id);

        // Return single post as a resource
        return new DataResource(true, 'Detail Data Item!', $venue);
    }

    public function destroy($id)
{
    $image = Image::where('id_image', $id)->first();
    
    Storage::delete('public/posts/' . basename($image->image));

    // Then delete the venue
    $image= Image::where('id_image', $id)->delete();

    // Return a response indicating success
    return new DataResource(true, 'Venue and associated images removed successfully.', "data");
}
}
