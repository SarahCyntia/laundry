<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('booking', function (Blueprint $table) {
            $table->id();
            $table->string('note');
            $table->foreignId('service_id')->constrained('service')->onDelete('cascade');
            $table->foreignId('laundry_type_id')->constrained('laundry_type')->onDelete('cascade');
            $table->integer('total_price');
            $table->double('total_wight');
            $table->enum('status_booking', ['tertunda', 'konfirmasi', 'selesai', 'batal']);
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('booking');
    }
};
