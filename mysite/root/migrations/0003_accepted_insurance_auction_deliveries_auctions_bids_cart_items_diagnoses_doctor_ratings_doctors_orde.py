# -*- coding: utf-8 -*-
# Generated by Django 1.10.5 on 2017-04-17 16:16
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('root', '0002_auto_20170410_0246'),
    ]

    operations = [
        migrations.CreateModel(
            name='Accepted_Insurance',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('doctor_id', models.IntegerField()),
                ('insurance_name', models.CharField(max_length=40)),
            ],
        ),
        migrations.CreateModel(
            name='Auction_deliveries',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_id', models.IntegerField()),
                ('auction_id', models.IntegerField()),
                ('address', models.CharField(max_length=60)),
                ('status', models.CharField(max_length=30)),
            ],
        ),
        migrations.CreateModel(
            name='Auctions',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('auction_id', models.IntegerField()),
                ('reserve_price', models.DecimalField(decimal_places=2, max_digits=5)),
                ('end_date', models.DateField(auto_now_add=True)),
                ('remedy_id', models.IntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='Bids',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('amount', models.DecimalField(decimal_places=2, max_digits=5)),
                ('user_id', models.IntegerField()),
                ('auction_id', models.IntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='Cart_items',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_id', models.IntegerField()),
                ('remedy_id', models.IntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='Diagnoses',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_id', models.IntegerField()),
                ('illness_id', models.IntegerField()),
                ('likelihood', models.PositiveIntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='Doctor_Ratings',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('doctor_id', models.IntegerField()),
                ('rating', models.DecimalField(decimal_places=2, max_digits=5)),
                ('comment', models.CharField(max_length=500)),
            ],
        ),
        migrations.CreateModel(
            name='Doctors',
            fields=[
                ('name', models.CharField(max_length=40)),
                ('doctor_id', models.AutoField(primary_key=True, serialize=False)),
                ('rating', models.DecimalField(decimal_places=2, max_digits=2)),
                ('address', models.CharField(max_length=60)),
            ],
        ),
        migrations.CreateModel(
            name='Order_Deliveries',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_id', models.IntegerField()),
                ('order_id', models.IntegerField()),
                ('address', models.CharField(max_length=60)),
                ('status', models.CharField(max_length=30)),
            ],
        ),
        migrations.CreateModel(
            name='Order_Items',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('order_id', models.IntegerField()),
                ('remedy_id', models.IntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='Orders',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('order_id', models.IntegerField()),
                ('order_date', models.DateTimeField(auto_now_add=True)),
                ('user_id', models.IntegerField()),
                ('repurchase_date', models.DateTimeField(auto_now_add=True)),
            ],
        ),
        migrations.CreateModel(
            name='Payment_Information',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('address', models.CharField(max_length=60)),
                ('card_number', models.CharField(max_length=20)),
                ('user_id', models.IntegerField(max_length=9)),
            ],
        ),
        migrations.CreateModel(
            name='Remedy_Ratings',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('remedy_id', models.IntegerField()),
                ('rating', models.DecimalField(decimal_places=2, max_digits=5)),
                ('comment', models.CharField(max_length=500)),
                ('user_id', models.IntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='Symptoms',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('symptom_id', models.IntegerField()),
                ('area_of_body', models.CharField(max_length=40)),
                ('description', models.CharField(max_length=200)),
                ('illness_id', models.IntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='Treatments',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('remedy_id', models.DecimalField(decimal_places=0, max_digits=9)),
                ('illness_id', models.IntegerField()),
            ],
        ),
    ]
