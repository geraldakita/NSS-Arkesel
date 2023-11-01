<?php

namespace App\Http\Controllers;

use App\Models\Account;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class AccountController extends Controller
{
    public function index()
    {
        $account = Account::all();

        $data = [
            'status' => 200,
            'account' => $account,
        ];

        return response()->json($data, 200);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'email' => 'required|email',
        ]);


        if ($validator->fails()) {
            $data = [
                'status' => 422,
                'message' => $validator->messages(),
            ];
            return response()->json($data, 422);
        } else {
            $account = new Account();
            $account->name = $request->name;
            $account->email = $request->email;
            $account->phone = $request->phone;

            // Generate an API key for the user and save it
            $account->api_key = bin2hex(random_bytes(32)); // Generate a random API key

            $account->save();

            $data = [
                'status' => 200,
                'message' => 'Data uploaded successfully',
            ];

            return response()->json($data, 200);
        }
    }

    public function edit(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'email' => 'required|email',
        ]);


        if ($validator->fails()) {
            $data = [
                'status' => 422,
                'message' => $validator->messages(),
            ];
            return response()->json($data, 422);
        } else {
            $account = Account::findOrFail($id);
            $account->name = $request->name;
            $account->email = $request->email;
            $account->phone = $request->phone;

            $account->save();

            $data = [
                'status' => 200,
                'message' => 'Data updated successfully',
            ];

            return response()->json($data, 200);
        }
    }

    public function delete($id)
    {
        $account = Account::findOrFail($id);
        $account->delete();

        $data = [
            'status' => 200,
            'message' => 'Data Deleted successfully',
        ];

        return response()->json($data, 200);
    }
}
