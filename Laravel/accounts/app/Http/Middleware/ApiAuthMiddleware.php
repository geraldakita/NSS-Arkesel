<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use App\Models\Account;
use Symfony\Component\HttpFoundation\Response;

class ApiAuthMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        $apiKey = $request->header('X-API-KEY');

        if ($apiKey) {
            $account = Account::where('api_key', $apiKey)->first();

            if ($account) {
                $requestedAccountId = $request->route('id');

                // Check if the request is for the authenticated account
                if ($requestedAccountId !== null && $requestedAccountId !== strval($account->id)) {
                    // Unauthorized: The request is trying to edit or delete another account.
                    $data = [
                        'status' => 403, // 403 Forbidden
                        'message' => 'Access to other accounts is forbidden',
                    ];
                    return response()->json($data, 403);
                }

                // User is authenticated
                return $next($request);
            }
        }

        $data = [
            'status' => 401,
            'message' => 'Unauthorized',
        ];


        return response()->json($data, 401);
    }
}
