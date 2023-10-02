<?php

namespace App\Http\Controllers\api;

use App\Models\Image;
use App\Models\Venue;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
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
            'image' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);

        //check if validation fails
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        //upload image
        $image = $request->file('image');
        $image->storeAs('public/img/' . $request->id_venue . '/' . $request->spot_id, $image->hashName());

        //create post
        $image = Image::create([
            'id_venue' => $request->id_venue,
            'image' => $request->id_venue . '/' . $request->spot_id . '/' . $image->hashName(),
            'spot_id' => $request->spot_id,
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

        $start = 'public/img/' . $image->id_venue . '/' . $image->spot_id . '/' . basename($image->image);

        $warning = Storage::delete('public/img/' . $image->id_venue . '/' . $image->spot_id . '/' . basename($image->image));

        // Then delete the venue
        $image = Image::where('id_image', $id)->delete();

        // Return a response indicating success
        return new DataResource(true, 'images removed successfully.', $start);
    }
}
