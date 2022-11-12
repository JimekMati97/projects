# Generated by Django 4.0.3 on 2022-08-30 16:33

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('auth', '0012_alter_user_first_name_max_length'),
    ]

    operations = [
        migrations.CreateModel(
            name='Account',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('password', models.CharField(max_length=128, verbose_name='password')),
                ('name', models.CharField(error_messages={'required': 'Name has to be set'}, max_length=20)),
                ('surname', models.CharField(max_length=20)),
                ('email', models.EmailField(max_length=40, unique=True)),
                ('dateOfBirth', models.DateField(max_length=10, null=True)),
                ('gender', models.CharField(choices=[('male', 'male'), ('female', 'female')], max_length=10)),
                ('country', models.CharField(choices=[('Poland', 'Poland'), ('Hungary', 'Hungary')], max_length=10)),
                ('profileImg', models.ImageField(blank=True, null=True, upload_to='')),
                ('is_loggedIn', models.BooleanField(default=False)),
                ('last_login', models.DateTimeField(auto_now=True, verbose_name='last login')),
                ('date_joined', models.DateTimeField(auto_now=True, verbose_name='date joined')),
                ('notifications', models.IntegerField(default=0)),
                ('is_admin', models.BooleanField(default=False)),
                ('is_active', models.BooleanField(default=True)),
                ('is_superuser', models.BooleanField(default=False)),
                ('is_staff', models.BooleanField(default=False)),
                ('hide_email', models.BooleanField(default=True)),
                ('groups', models.ManyToManyField(blank=True, help_text='The groups this user belongs to. A user will get all permissions granted to each of their groups.', related_name='user_set', related_query_name='user', to='auth.group', verbose_name='groups')),
                ('user_permissions', models.ManyToManyField(blank=True, help_text='Specific permissions for this user.', related_name='user_set', related_query_name='user', to='auth.permission', verbose_name='user permissions')),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='Commentt',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('text', models.CharField(blank=True, max_length=200)),
                ('time', models.DateTimeField(default=django.utils.timezone.now)),
                ('author', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Conversation',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user1', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='user1', to=settings.AUTH_USER_MODEL, to_field='email')),
                ('user2', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='user2', to=settings.AUTH_USER_MODEL, to_field='email')),
            ],
        ),
        migrations.CreateModel(
            name='Like',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('time', models.DateTimeField(default=django.utils.timezone.now)),
                ('author', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Post',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(blank=True, max_length=100)),
                ('body', models.CharField(blank=True, max_length=1000)),
                ('time', models.DateTimeField(default=django.utils.timezone.now)),
                ('author', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='PostLikee',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('time', models.DateTimeField(default=django.utils.timezone.now)),
                ('like', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='coApp.like')),
                ('post', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='coApp.post')),
            ],
        ),
        migrations.CreateModel(
            name='PostComentee',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('time', models.DateTimeField(default=django.utils.timezone.now)),
                ('comment', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='coApp.commentt')),
                ('post', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='coApp.post')),
            ],
        ),
        migrations.AddField(
            model_name='post',
            name='comments',
            field=models.ManyToManyField(through='coApp.PostComentee', to='coApp.commentt'),
        ),
        migrations.AddField(
            model_name='post',
            name='likes',
            field=models.ManyToManyField(through='coApp.PostLikee', to='coApp.like'),
        ),
        migrations.CreateModel(
            name='Messege',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('messege', models.CharField(blank=True, max_length=1000)),
                ('time', models.DateTimeField(default=django.utils.timezone.now)),
                ('author', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
                ('convId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='coApp.conversation')),
            ],
        ),
        migrations.CreateModel(
            name='AccountsRelation',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date_of_relation_est', models.DateTimeField(auto_now=True)),
                ('verified', models.CharField(choices=[('noResponse', 'noResponse'), ('rejected', 'rejected'), ('accepted', 'accepted')], default='noResponse', max_length=40)),
                ('senderInformed', models.CharField(blank=True, choices=[('yes', True), ('no', False)], default='no', max_length=10)),
                ('addresseeInformed', models.CharField(blank=True, choices=[('yes', True), ('no', False)], default='no', max_length=10)),
                ('dateOfSending', models.DateTimeField(null=True)),
                ('addressee', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='addressee', to=settings.AUTH_USER_MODEL, to_field='email')),
                ('sender', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='sender', to=settings.AUTH_USER_MODEL, to_field='email')),
            ],
        ),
    ]