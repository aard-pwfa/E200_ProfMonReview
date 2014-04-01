function loadimage(handles)
	disp('Here');

	maxval=int32(get(handles.Maxcounts,'Value'));
	minval=int32(get(handles.Mincounts,'Value'));
	imagesc(handles.data.img-handles.data.back,[minval,maxval]);
	colorbar;
end
