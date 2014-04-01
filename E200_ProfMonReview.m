function varargout = E200_ProfMonReview(varargin)
% E200_PROFMONREVIEW M-file for E200_ProfMonReview.fig
%      E200_PROFMONREVIEW, by itself, creates a new E200_PROFMONREVIEW or raises the existing
%      singleton*.
%
%      H = E200_PROFMONREVIEW returns the handle to a new E200_PROFMONREVIEW or the handle to
%      the existing singleton*.
%
%      E200_PROFMONREVIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in E200_PROFMONREVIEW.M with the given input arguments.
%
%      E200_PROFMONREVIEW('Property','Value',...) creates a new E200_PROFMONREVIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before E200_ProfMonReview_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to E200_ProfMonReview_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help E200_ProfMonReview

% Last Modified by GUIDE v2.5 31-Mar-2014 19:17:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @E200_ProfMonReview_OpeningFcn, ...
                   'gui_OutputFcn',  @E200_ProfMonReview_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before E200_ProfMonReview is made visible.
function E200_ProfMonReview_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to E200_ProfMonReview (see VARARGIN)

% Choose default command line output for E200_ProfMonReview
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes E200_ProfMonReview wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = E200_ProfMonReview_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

searchpath='/u1/facet/matlab/data';

% Extract most recent file location
dirs       = dir(searchpath);
% Convert to structure
dirs=struct2cell(dirs);
% Order by date
date=dirs(5,:);
date=cell2mat(date);
[ignore,ind]=sort(date);
dirs=dirs(:,ind);
first=dirs{1,end};

searchpath = fullfile(searchpath,first);
dirs       = dir(searchpath);
second     = dirs(end).name;
searchpath = fullfile(searchpath,second);
dirs       = dir(searchpath);
third      = dirs(end).name;
searchpath = fullfile(searchpath,third);

curpath=pwd;
cd(searchpath);
[Filename,Pathname,FilterIndex]=uigetfile('ProfMon*.mat','Open E200 scan_info file');
cd(curpath);

load(fullfile(Pathname,Filename))
maxcounts=max(max(data.img));
set(handles.Maxcounts,'Max',maxcounts);
set(handles.Maxcounts,'Value',maxcounts);
set(handles.Maxcounts,'SliderStep',[0.01,0.1])

set(handles.Mincounts,'Max',maxcounts-1);
set(handles.Mincounts,'Value',0);
set(handles.Mincounts,'SliderStep',[0.01,0.1])

handles.data=data;
handles.filename=Filename;

guidata(hObject, handles);

loadimage(handles);


% --- Executes on slider movement.
function Maxcounts_Callback(hObject, eventdata, handles)
% hObject    handle to Maxcounts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

loadimage(handles);

% --- Executes on slider movement.
function Mincounts_Callback(hObject, eventdata, handles)
% hObject    handle to Mincounts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

loadimage(handles);


% --------------------------------------------------------------------
function printbutton_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to printbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


fig=figure();
ax=axes();
% [img,imgnum]=img2plot(handles);
loadimage(handles);

xlim_main=get(handles.fig1,'XLim');
ylim_main=get(handles.fig1,'YLim');
% set(ax,'XLim',xlim_main);
% set(ax,'YLim',ylim_main);

prompt    = {'Title','X Label','Y Label','Elog Title','Comment to Print'};
dlg_title = 'Plot Details';
num_lines = [1,30;1,20;1,20;1,30;10,50];

% [temp,camname] = get_imgstruct(handles);
% dataset        = handles.data.raw.metadata.param.dat{1}.save_name;
camname = handles.data.name;
dataset = handles.filename;
comment2print  = sprintf(['Dataset: ' dataset]);
def            = {camname,'','',['ProfMon from ' camname],comment2print};

result=inputdlg(prompt,dlg_title,num_lines,def);
comment2print = flattenstringrows(result{5})

addlabels(result{2},result{3},result{1});
colorbar('off');
colorbar;

printans=questdlg(sprintf(['Comment: \n\n=====================\n\n' comment2print '\n\n=====================\n\nPrint to Elog?']),'Final Confirmation','Yes','No','No');
if strcmp(printans,'Yes')
	authstr=handles.data.raw.metadata.param.dat{1}.experiment;
	util_printLog(fig,'title',result{4},'text',sprintf(comment2print),'author',authstr);
end


% --- Executes during object creation, after setting all properties.
function Mincounts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Mincounts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function Maxcounts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Maxcounts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


