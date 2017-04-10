# -*- coding: utf-8 -*-
# Generated by Django 1.10.5 on 2017-04-10 02:46
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('root', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Exhibits',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
            ],
        ),
        migrations.CreateModel(
            name='Illness',
            fields=[
                ('name', models.CharField(max_length=200)),
                ('illid', models.AutoField(primary_key=True, serialize=False)),
                ('description', models.CharField(default=b'Description', max_length=500)),
                ('prefgender', models.BooleanField(default=False)),
            ],
        ),
        migrations.CreateModel(
            name='Remedy',
            fields=[
                ('name', models.CharField(max_length=100)),
                ('remid', models.AutoField(primary_key=True, serialize=False)),
                ('purchasable', models.BooleanField(default=False)),
                ('supplier', models.CharField(max_length=100)),
                ('directcost', models.DecimalField(decimal_places=2, default=0.0, max_digits=9)),
            ],
        ),
        migrations.CreateModel(
            name='SuffersFrom',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('duration', models.DurationField(default=0)),
            ],
        ),
        migrations.CreateModel(
            name='Symptom',
            fields=[
                ('name', models.CharField(max_length=100)),
                ('sid', models.AutoField(primary_key=True, serialize=False)),
            ],
        ),
        migrations.CreateModel(
            name='TreatedBy',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('illness', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='root.Illness')),
                ('remedy', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='root.Remedy')),
            ],
        ),
        migrations.CreateModel(
            name='User',
            fields=[
                ('name', models.CharField(max_length=100)),
                ('uid', models.AutoField(primary_key=True, serialize=False)),
                ('gender', models.BooleanField(default=False)),
                ('email', models.EmailField(max_length=254)),
                ('height', models.DecimalField(decimal_places=2, max_digits=5)),
                ('weight', models.DecimalField(decimal_places=2, max_digits=5)),
                ('symptoms', models.ManyToManyField(through='root.SuffersFrom', to='root.Symptom')),
            ],
        ),
        migrations.AddField(
            model_name='suffersfrom',
            name='symptom',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='root.Symptom'),
        ),
        migrations.AddField(
            model_name='suffersfrom',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='root.User'),
        ),
        migrations.AddField(
            model_name='illness',
            name='remedies',
            field=models.ManyToManyField(through='root.TreatedBy', to='root.Remedy'),
        ),
        migrations.AddField(
            model_name='illness',
            name='symptoms',
            field=models.ManyToManyField(through='root.Exhibits', to='root.Symptom'),
        ),
        migrations.AddField(
            model_name='exhibits',
            name='illness',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='root.Illness'),
        ),
        migrations.AddField(
            model_name='exhibits',
            name='symptom',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='root.Symptom'),
        ),
    ]