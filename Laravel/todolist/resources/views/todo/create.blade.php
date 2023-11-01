@extends('layouts.layout')
@section('content')
<div class="wrapper create-todo">
    <h1>Create a New Task</h1>
    <h3><a href="/">Back to all Tasks</a>
    <form action="/" method="post">
        @csrf
        <label for="name">Your Name:</label>
        <input type="text" id="name" name="name">

        <label for="title">Title:</label>
        <input id="title" name="title">

        <label for="description">Description:</label>
        <input id="description" name="description">
        </br>
        <input type="submit" value="Create Task">
    </form>
</div>
@endsection