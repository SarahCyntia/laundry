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
        Schema::create('payment', function (Blueprint $table) {
            $table->id();
            $table->integer('jumlah_pembayaran');
            $table->foreignId('booking_id')->constrained('booking')->onDelete('cascade');
            $table->enum('payment_type', ['cash', 'credit_card', 'bank_transfer', 'e_wallet', 'Qris']);
            $table->enum('status_payment', ['pending', 'paid', 'failed', 'e_wallet', 'debt']);
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade'); 
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payment');
    }
};
