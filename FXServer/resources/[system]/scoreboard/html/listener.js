$(function()
{
    window.addEventListener('message', function(event)
    {
        var item = event.data;
        var buf = $('#wrap');
        buf.find('table').append("<h1 class=\"heading\">Venus ROLEPLAY</h1><img class='image' src='https://cdn.pixabay.com/photo/2017/03/17/05/20/info-2150938_640.png'><p id='website'>Qualquer dúvida:</p><p id='discord'>https://discord.gg/k2mQHZn</p>");
        if (item.meta && item.meta == 'close')
        {
            document.getElementById("ptbl").innerHTML = "";
            $('#wrap').hide();
            return;
        }
        buf.find('table').append(item.text);
        $('#wrap').show();
    }, false);
});